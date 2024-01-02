//
//  DetailsView.swift
//  FlickrApp
//
//  Created by Soha Ahmed on 08/12/2023.
//

import SwiftUI

struct DetailsView: View {
    var photo: Photo
    
    var body: some View{
        
        ScrollView {
            AsyncImage(
                url: URL(string:photo.url_l ?? ""),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: CGFloat(photo.width_l ?? 100), maxHeight: CGFloat(photo.height_l ?? 100))
                },
                placeholder: {
                    Image(systemName: "network.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 90)
                        .clipped()
                })
            Text(photo.title)
                .font(.title2)
                .fontWeight(.semibold)
                .scaledToFit()
                .minimumScaleFactor(0.5)
            Text("by: \(photo.ownername ?? photo.owner) 🗓️ \(photo.getDate())")
                .font(.subheadline)
            Text(photo.geo ?? "")
            let tags = photo.getTags()
            if !tags.isEmpty{
                TagView(tags: tags)
            }
            Spacer()
            
            Text(photo.description?._content ?? "No description available")
                .font(.body)
                .fontWeight(.semibold)
                .padding()
        }
    }
}


#Preview {
    DetailsView(photo: Photo(id: "", owner: "owner name", url_l: "https://live.staticflickr.com/65535/53414590793_0502b3e30f_b.jpg", description: Description(_content: "Seeing the northern lights is a life changing experience for many.  But how do you know when to go?  And when you get there, how do you photograph it?  See comment section.  Here are a few images I took earlier in the year."),tags:"actionphototours auroraborealis northernlights aurora iceland night nightphotography"))
}
