//
//  WineGalleryApp.swift
//  WineGallery
//
//  Created by Anilkumar on 21/02/23.
//

import SwiftUI

@main
/// WineGalleryApp - this is the main view, from here we will load our application related views
struct WineGalleryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: WineGalleryViewModel(
                    appClient: .live
                )
            )
        }
    }
}
