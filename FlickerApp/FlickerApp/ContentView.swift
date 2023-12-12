//
//  ContentView.swift
//  FlickerApp
//
//  Created by Soha Ahmed on 08/12/2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        VStack{
//            HStack{
//                Text("user name")
//                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                    .foregroundStyle(.indigo)
//                Spacer()
//                
//                AsyncImage(url: URL(string:"https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg")!,
//                content: { image in
//                    image.resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(maxWidth: 100, maxHeight:100)
//                },
//                placeholder: {
//                    Image(systemName: "person")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(height: 150)
//                        .clipped()
//                })
//            }
            SearchView()
        }.ignoresSafeArea()
//        TabView {
//            ImageListView()
//                .tabItem  {
//                    Image(systemName: "house")
//                    Text("Home")
//                }
//            
//
//                .tabItem  {
//                    Image(systemName: "magnifyingglass")
//                    Text("search")
//                }
//        }.accentColor(Color("primary"))
        }
    
    }
    
    #Preview {
        ContentView()
    }
    
    
