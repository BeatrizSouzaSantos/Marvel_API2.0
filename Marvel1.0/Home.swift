//
//  Home.swift
//  Marvel1.0
//
//  Created by user195594 on 5/19/21.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    var body: some View {
        
        TabView{
            // Characters View
            CharactersView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Characters")
                }
            
                .environmentObject(homeData)
            
            ComicsView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Comics")
                }
                .environmentObject(homeData)
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View{
        Home()
    }
}

