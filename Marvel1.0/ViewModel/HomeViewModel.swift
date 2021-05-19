import SwiftUI
import Combine
import CryptoKit

class HomeViewModel: ObservableObject{

    @Published var searchQuery = ""

    //Combinar barra de pesquisa do framework
    var searchCancellable: AnyCancellable? = nil

    //Buscando dados
    @Published var fetchedCharacters: [Character]? = nil
    
    //Dados da Comic View
    @Published var fetchedComics: [Comic] = []
    
    @Published var offset: Int = 0

    init() {
        // Já que SwiftUI usa @published, então é um editor
        // so need dont to explicity define publisher
        searchCancellable = $searchQuery
            //Removendo digitações duplicadas
            .removeDuplicates()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { str in

               if str == ""{
                    // Redefinir dados...
                    self.fetchedCharacters = nil
                }
                else{
                    self.searchCharacter()
                    
                }
          })
     }

     func searchCharacter(){
     
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        
        let originalQuery = searchQuery.replacingOccurrences(of: " ", with: "%20")
        let url = "https://gateway.marvel.com:443/v1/public/characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)&nameStartsWith=\(originalQuery)"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            
            if let error = err {
                print(error)
                return
            }
            
            guard let APIData = data else {
                print("no data found")
                return
            }
            
            do{
                
                // Decoding API Data
                
                let characters = try JSONDecoder().decode(APIResult.self, from: APIData)
                
                DispatchQueue.main.async {
                    
                    if self.fetchedCharacters == nil{
                        self.fetchedCharacters = characters.data.results
                    }
                }
            }
            catch{
                print(error)
            }
        }
        .resume()
     }

    // Para gerar Hash para usar CryptoKit
    func MD5(data: String)->String {
        
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        
        return hash.map{
            String(format: "%02hhx", $0)
        }
        .joined()
    }
    
    func fetchComics(){
    
       let ts = String(Date().timeIntervalSince1970)
       let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
       
       let url = "https://gateway.marvel.com:443/v1/public/comics?limit=20&offset=\(offset)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
       
       let session = URLSession(configuration: .default)
       
       session.dataTask(with: URL(string: url)!) { (data, _, err) in
           
           if let error = err {
               print(error)
               return
           }
           
           guard let APIData = data else {
               print("no data found")
               return
           }
           
           do{
               
               // Decoding API Data
               
               let characters = try JSONDecoder().decode(APIComicResult.self, from: APIData)
               
               DispatchQueue.main.async {
                    self.fetchedComics.append(contentsOf: characters.data.results)
               }
           }
           catch{
               print(error)
           }
       }
       .resume()
    }

}
