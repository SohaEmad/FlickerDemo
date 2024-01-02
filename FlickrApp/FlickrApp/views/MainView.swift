//
//  MainView.swift
//  FlickrApp
//
//  Created by Soha Ahmed on 21/12/2023.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var modelView: ModelView
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("", systemImage: "house")
                }.tag(Tab.home)
            
            SearchView()
                .tabItem {
                    Label("", systemImage: "magnifyingglass")
                }.tag(Tab.search)
            
            LocationBasedView()
                .tabItem {
                    Label("", systemImage: "mappin.and.ellipse")
                }.tag(Tab.location)
            
            UserUrlInputView()
                .tabItem {
                    Label("", systemImage: "person")
                }.tag(Tab.user)
        }
    }
}

enum Tab: String {
    case home
    case search
    case location
    case user
}


#Preview {
    MainView()
        .environmentObject(ModelView())
}
