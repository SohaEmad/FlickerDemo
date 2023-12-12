//
//  ToolBarView.swift
//  Flicker
//
//  Created by Soha Ahmed on 09/12/2023.
//

import SwiftUI

struct ToolBarView: View {
    @ObservedObject var modelView = ModelView()
    
    var body: some View {
        HStack{
            Button (action: {
                
                
            }, label: {
                Image(systemName: "person.crop.circle")
                    .imageScale(.large)
            }
            )
            Spacer()
            
            Text("userName")

            AsyncImage(
                url: URL(string:modelView.userUrl),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(height: 90)
                        .clipped()
                },
                placeholder: {
                    Image(systemName: "person.crop.circle")
                        .scaledToFit()
                        .imageScale(.large)
                        .clipped()
                })
        }
        
    }
}

#Preview {
    ToolBarView()
}
