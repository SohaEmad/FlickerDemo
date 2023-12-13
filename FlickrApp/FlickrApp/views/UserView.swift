//
//  UserView.swift
//  Flickr
//
//  Created by Soha Ahmed on 09/12/2023.
//

import SwiftUI

struct UserView: View {
    
    @ObservedObject var modelView: ModelView
    
    var body: some View {
        VStack {
//            Text(modelView.user?.username?._content ?? "User name")
            AsyncImage(url: URL(string: String(format:Constatnts.PROFILE_PHOTO,modelView.user?.id ?? Constatnts.USER_ID))){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.circle)
                    .frame(width: 100, height: 100)
                
            } placeholder: {
                Circle()
                    .frame(width: 30, height: 30)
            }
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
                            modelView.loadMorePhotos(usingUserId: true)
                        }
                }
                .edgesIgnoringSafeArea(.horizontal)
                .listStyle(GroupedListStyle())
                .listRowSeparator(.hidden,
                                  edges: .bottom)
                .padding(.bottom)
            }
            
        } .onAppear{
            modelView.getPhotos(useUserId: true)
        }
    }
}
