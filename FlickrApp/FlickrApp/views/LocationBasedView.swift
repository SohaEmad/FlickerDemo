//
//  LocationBasedView.swift
//  FlickrApp
//
//  Created by Soha Ahmed on 21/12/2023.
//

import SwiftUI
import CoreLocation

struct LocationBasedView: View {
    
    @StateObject var locationProvider = LocationProvider()
    @ObservedObject var modelView: ModelView
    
    var body: some View {
        VStack{
            if !locationProvider.authoried {
                Text("please enable location access")
            }
            
            NavigationStack {
                ImageListView(modelView: modelView)
                    .edgesIgnoringSafeArea(.horizontal)
                    .listStyle(GroupedListStyle())
                    .listRowSeparator(.hidden,
                                      edges: .bottom)
                    .padding(.bottom)
            }
            .searchable(text: $modelView.searchText, placement: .navigationBarDrawer(displayMode: .automatic))
                .onChange(of: modelView.searchText) { _ in
                    modelView.getPhotos()
                }
            .onAppear{
                Task{
                    modelView.getPhotos(location: locationProvider.curentLocaiton)
                }
            }
            
       
        }
    }
}

#Preview {
    LocationBasedView(modelView: ModelView())
}
