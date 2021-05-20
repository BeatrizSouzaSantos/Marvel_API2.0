//
//  ComicsView.swift
//  Marvel1.0
//
//  Created by user195594 on 5/19/21.
//

import SwiftUI
import SDWebImageSwiftUI
//MARK: - View
struct ComicsView: View {
    @EnvironmentObject var homeData: HomeViewModel
    var body: some View {
        
        NavigationView{
            
            ScrollView(.vertical, showsIndicators: false, content: {
                        
                        if homeData.fetchedComics.isEmpty{
                            
                            ProgressView()
                                .padding(.top,30)
                        }
                        else{
                            
//MARK: - Displaying Contents
                            
                            VStack(spacing: 15){
                              
                                ForEach(homeData.fetchedComics){comic in
                                    
                                    ComicRowView(character: comic)
                                }
                                
                                if homeData.offset == homeData.fetchedComics.count{
                                    
                                    ProgressView()
                                        .padding(.vertical)
                                        .onAppear(perform: {
                                            print("fetching new data..")
                                            homeData.fetchComics()
                                        })
                                }
                                else{
                                    
                                    GeometryReader{reader -> Color in
                                        
                                        let minY = reader.frame(in: .global).minY
                                        
                                        let height = UIScreen.main.bounds.height / 1.3
                                        
                                        if !homeData.fetchedComics.isEmpty && minY < height{
                                            
                                            DispatchQueue.main.async {
                                                
                                                homeData.offset = homeData.fetchedComics.count
                                            }
                                        }
                                        
                                        return Color.clear
                                    }
                                    .frame(width: 20, height: 20)
                                }
                            }
                            .padding(.vertical)
                        }
                    })
                    .navigationTitle("Marvel's Comics")
            }
            //MARK: - Loading Data
            .onAppear(perform: {
                if homeData.fetchedComics.isEmpty{
                    homeData.fetchComics()
                }
            })
        }
    }

struct ComicsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ComicRowView: View {
    
    var character: Comic
    
    var body: some View{
        
        HStack(alignment: .top, spacing: 15){
            
            WebImage(url: extractImage(data: character.tumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text(character.title)
                    .font(.title3)
                    .fontWeight(.bold)
                
                if let description = character.description{
                    
                Text(description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
                }
                
                //MARK: - Links
                HStack(spacing:10){
                    
                    ForEach(character.urls,id: \.self){data in
                        NavigationLink(
                                destination: WebView(url: extractURL(data: data))
                                    .navigationTitle(extractURLType(data: data)),
                                label: {
                                    Text(extractURLType(data: data))
                                })
                    }
                }
            })
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal)
    }
    
    func extractImage(data: [String:String])->URL{
        
        //MARK: - Combinando e formando as imagens
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        
        return URL(string: "\(path).\(ext)")!
    }
    
    func extractURL(data: [String:String])->URL{
    
        let url = data["url"] ?? ""
        
        return URL(string: url)!
    }
    
    func extractURLType(data: [String:String])->String{
        
        let type = data["type"] ?? ""
        
        return type.capitalized
    }
}
