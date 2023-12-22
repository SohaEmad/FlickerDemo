//
//  MainView.swift
//  FlickrApp
//
//  Created by Soha Ahmed on 21/12/2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var modelView: ModelView
    var body: some View {
        TabView {
            HomeView(modelView: modelView)
                .tabItem {
                    Label("", systemImage: "house")
                }
            
            SearchView(modelView: modelView)
                .tabItem {
                    Label("", systemImage: "magnifyingglass")
                }
            
            LocationBasedView(modelView: modelView)
                .tabItem {
                    Label("", systemImage: "mappin.and.ellipse")
                }
            
            UserUrlInputView(modelView: modelView)
                .tabItem {
                    Label("search User", systemImage: "person")
                }
        }
    }
}

#Preview {
    MainView(modelView: ModelView())
}
