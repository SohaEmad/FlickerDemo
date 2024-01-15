//
//  UserView.swift
//  Flickr
//
//  Created by Soha Ahmed on 09/12/2023.
//

import SwiftUI

struct UserView: View {
    
    @EnvironmentObject var modelView : ModelView
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: String(format:Constatnts.PROFILE_PHOTO,modelView.user?.id ?? Constatnts.USER_ID))){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.circle)
                    .frame(width: 100, height: 100)
                
            } placeholder: {
                Image(systemName: "person")
                    .scaledToFit()
                    .frame(height: 90)
                    .clipped()
            }
            Text(modelView.user?.username?._content ?? "Invalid User Name")
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
            }
            .edgesIgnoringSafeArea(.horizontal)
            .listStyle(GroupedListStyle())
            .listRowSeparator(.hidden,
                              edges: .bottom)
            .padding(.bottom)
        } .onAppear{
            modelView.getPhotos(useUserId: true)
        }
    }
}

#Preview {
    UserView()
        .environmentObject(ModelView())
}
