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
            VStack{
//                UserView(modelView: modelView)
                Text(modelView.userID)
            }
        }
        .searchable(text: $modelView.userName)
        .onChange(of: modelView.userName) { _ in
            modelView.getUserID()
//            modelView.getPhotos(useUserId: true)
        }
        .onAppear{
            modelView.getUserID()
        }
    }
}

#Preview {
    UserUrlInputView(modelView: ModelView())
}
