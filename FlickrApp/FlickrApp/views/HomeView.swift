//
//  HomeView.swift
//  FlickrApp
//
//  Created by Soha Ahmed on 21/12/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var modelView: ModelView
    
    var body: some View {
        NavigationStack {
            ImageListView(modelView: modelView)
            .edgesIgnoringSafeArea(.horizontal)
            .listStyle(GroupedListStyle())
            .listRowSeparator(.hidden,
                              edges: .bottom)
            .padding(.bottom)
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(destination: UserUrlInputView(modelView: modelView)) {
                        
                        Image("home")
                            .resizable()
                            .frame(width: 40)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    HStack{
                        Spacer()
                        
                        Text("User Id : \(modelView.user?.id ?? "")")
                        Spacer()
                        
                        NavigationLink(destination: UserView(modelView: modelView)) {
                            AsyncImage(
                                url: URL(string:modelView.user?.profilePhoto ?? ""),
                                content: { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .scaledToFit()
                                        .clipShape(.circle)
                                },
                                placeholder: {
                                    Image(systemName: "person")
                                        .scaledToFit()
                                        .frame(height: 90)
                                        .clipped()
                                })
                        }
                    }
                }
                
            }    }
    }
}

#Preview {
    HomeView(modelView: ModelView())
}
