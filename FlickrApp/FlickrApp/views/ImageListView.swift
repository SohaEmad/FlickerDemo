//
//  SwiftUIView.swift
//  FlickrApp
//
//  Created by Soha Ahmed on 21/12/2023.
//

import SwiftUI

struct ImageListView: View {
    @EnvironmentObject var modelView : ModelView
    
    var body: some View {
        List {
            ForEach(modelView.photos) { photo in
                VStack{
                    ImageView(photo: photo)
                }
            }
            Color.clear
                .frame(width: 0, height: 0, alignment: .bottom)
                .onAppear {
                    modelView.loadMorePhotos()
                }
        }
    }
}

#Preview {
    ImageListView()
}
