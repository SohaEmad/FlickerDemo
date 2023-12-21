//
//  SearchView.swift
//  FlickrApp
//
//  Created by Soha Ahmed on 08/12/2023.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var modelView: ModelView
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(modelView.photos) { photo in
                    VStack{
                        ImageView(photo: photo)
                            .background(
                                NavigationLink("", destination: DetailsView(photo: photo))
                                    .opacity(0)
                            )
                    }
                }
                Color.clear
                    .frame(width: 0, height: 0, alignment: .bottom)
                    .onAppear {
                        modelView.loadMorePhotos()
                    }
            }
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

                        Text(modelView.user?.id ?? "")
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
                
            }
            .searchable(text: $modelView.searchText)
            .onChange(of: modelView.searchText) { _ in
                modelView.getPhotos()
            }
            .onAppear{
                Task{
                    modelView.getPhotos()
                    modelView.getUserID()
                }
            }
        }
    }
}


#Preview {
    SearchView(modelView: ModelView())
}
