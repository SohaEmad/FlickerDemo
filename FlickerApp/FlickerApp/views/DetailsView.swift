//
//  DetailsView.swift
//  FlickerApp
//
//  Created by Soha Ahmed on 08/12/2023.
//

import SwiftUI

struct DetailsView: View {
    var photo: Photo
    
    var body: some View{
        
        VStack {
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
            Text("by: \(photo.owner)")
                .font(.subheadline)
            let tags = photo.getTags()
            if !tags.isEmpty{
                HStack{
                    ForEach (tags, id: \.self){  tag in
                        Label( tag, systemImage: "tag")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                }
            }
            Text(photo.desciption ?? "No description available")
                .font(.body)
                .fontWeight(.semibold)
                .padding()
            Spacer()
        }.padding(.bottom)
    }
}
