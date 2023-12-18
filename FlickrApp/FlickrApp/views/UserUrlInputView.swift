//
//  UserUrlInputView.swift
//  FlickrApp
//
//  Created by Soha Ahmed on 17/12/2023.
//

import SwiftUI

struct UserUrlInputView: View {
    @ObservedObject var modelView: ModelView
    var body: some View {
        NavigationView {
        ScrollView{
            Text("let's try another user")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding()
            
            Text("Enter any Flickr's unique username")
                .font(.subheadline)
            
            Image("profile")
                .resizable()
                .frame(width: 350, height: 200)
                .padding()
            
            TextField("Flickr User URL", text: $modelView.userName)
                .padding(.horizontal, 10)
                .frame(height: 42)
                .overlay(
                    RoundedRectangle(cornerSize: CGSize(width: 3, height: 4))
                        .stroke(Color.gray, lineWidth: 1)
                    
                ).onChange(of: modelView.userName, perform: { _ in
                    modelView.getUserID()
                })
            Text("URL: https://www.flickr.com/photos/\(modelView.userName)/")
                .padding()
                NavigationLink(destination: UserView(modelView: modelView)) {
                    if modelView.userID != ""{
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
                                    .frame(height: 60)
                                    .clipped()
                            })
                    }
                    let value = modelView.userID == "" ? "Invalid UserName" : "Hi 👋🏻 \(modelView.user?.username?._content ?? "")"
                    Text(value).font(.title3)
                        .foregroundStyle(.primary)
                }
            }
        }.onAppear{
            modelView.getUserID()
        }
    }
}

#Preview {
    UserUrlInputView(modelView: ModelView())
}
