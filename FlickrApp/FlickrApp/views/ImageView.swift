//
//  ImageView.swift
//  FlickrApp
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
                    Text(photo.title)
                        .font(.caption)
                        .bold()
                    let tags = photo.getTags(2)
                    if !tags.isEmpty{
                        TagView(tags: tags)
                    }
                },
                placeholder: {
                })
            .background(
                NavigationLink("", destination: DetailsView(photo: photo))
                    .opacity(0)
            )
            
        }
    }
}


#Preview {
    ImageView(photo: Photo(id: "", url_l: "https://live.staticflickr.com/65535/53414590793_0502b3e30f_b.jpg"))
}
