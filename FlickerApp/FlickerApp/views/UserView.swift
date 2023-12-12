//
//  UserView.swift
//  Flicker
//
//  Created by Soha Ahmed on 09/12/2023.
//

import SwiftUI

struct UserView: View {
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://farm9.staticflickr.com/8573/buddyicons/38945681@N07_l.jpg")){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.circle)
                    .frame(width: 100, height: 100)

            } placeholder: {
                Circle()
                    .frame(width: 30, height: 30)
            }
            ImageListView()
        }
    }
}

#Preview {
    UserView()
}
