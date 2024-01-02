//
//  SearchView.swift
//  FlickrApp
//
//  Created by Soha Ahmed on 08/12/2023.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var modelView : ModelView
    
    var body: some View {
        VStack{
            NavigationStack {
                ImageListView()
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
                        
                    }    }
            .searchable(text: $modelView.searchText, placement: .navigationBarDrawer(displayMode: .automatic))
            .onChange(of: modelView.searchText) { _ , _ in
                modelView.reset()
                modelView.getPhotos()
            }
            .onAppear{
                Task{
                    modelView.reset()
                    modelView.getPhotos()
                    modelView.getUserID()
                }
            }
            Toggle("  Use all tags", isOn: $modelView.allTags)
            
        }}
}


#Preview {
    SearchView()
        .environmentObject(ModelView())
    
}
