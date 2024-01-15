//
//  HomeView.swift
//  FlickrApp
//
//  Created by Soha Ahmed on 21/12/2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var modelView : ModelView
    
    var body: some View {
        NavigationStack {
            ImageListView(loadRecent: true)
                .edgesIgnoringSafeArea(.horizontal)
                .listStyle(GroupedListStyle())
                .listRowSeparator(.hidden,
                                  edges: .bottom)
                .padding(.bottom)

                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationLink(destination: UserUrlInputView()) {
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
                            
                            NavigationLink(destination: UserView()) {
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
                }
  
  
        }.onAppear{
            modelView.reset()
            modelView.getRecentPhotos()
            modelView.getUserID()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(ModelView())
}
