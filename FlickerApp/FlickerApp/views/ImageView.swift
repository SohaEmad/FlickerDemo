//
//  ImageView.swift
//  FlickerApp
//
//  Created by Soha Ahmed on 08/12/2023.
//

import SwiftUI

struct ImageView: View {
    var photo: Photo
    @State var showMoreDetials : Bool = false
    
    var body: some View {      
        VStack {
                AsyncImage(
                    url: URL(string:photo.url_l ?? ""),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: CGFloat(photo.width_l ?? 500), maxHeight: CGFloat(photo.height_l ?? 500))
                    },
                    placeholder: {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 90)
                            .clipped()
                    })
            Text(photo.title)
                .font(.caption)
                .bold()
            let tags = photo.getTags(2)
            if !tags.isEmpty{
                    HStack{
                        ForEach (tags, id: \.self){  tag in
                            Label( tag, systemImage: "tag")
                        }
                    }
                }           
        }
    }
}


