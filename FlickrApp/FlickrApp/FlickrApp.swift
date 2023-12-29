//
//  FlickrAppApp.swift
//  FlickrApp
//
//  Created by Soha Ahmed on 08/12/2023.
//

import SwiftUI

@main
struct FlickrApp: App {
    @ObservedObject var modelView = ModelView()
    var body: some Scene {
        WindowGroup {
            LoadingView()
                .environmentObject(modelView)
        }
    }
}
