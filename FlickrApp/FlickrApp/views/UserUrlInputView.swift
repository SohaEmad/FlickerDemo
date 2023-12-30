//
//  UserUrlInputView.swift
//  FlickrApp
//
//  Created by Soha Ahmed on 17/12/2023.
//

import SwiftUI

struct UserUrlInputView: View {
    @EnvironmentObject var modelView : ModelView
    
    var body: some View {
        NavigationView {
            UserView()
        }
        .searchable(text: $modelView.userName)
        .onChange(of: modelView.userName) { _, _ in
            modelView.getUserID()
        }
        .onSubmit(of: .search) {
            modelView.getPhotos(useUserId: true)
           }
        .onAppear{
            modelView.reset()
            modelView.getUserID()
        }
    }
}

#Preview {
    UserUrlInputView()
}
