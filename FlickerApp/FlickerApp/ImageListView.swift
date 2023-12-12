//
//  ImageListView.swift
//  FlickerApp
//
//  Created by Soha Ahmed on 08/12/2023.
//

import SwiftUI

struct ImageListView: View {
    @ObservedObject var modelView = ModelView()
    
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
        }
    }
}

#Preview {
    ImageListView()
}
