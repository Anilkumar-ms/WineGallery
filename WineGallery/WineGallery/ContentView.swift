//
//  ContentView.swift
//  WineGallery
//
//  Created by Anilkumar on 21/02/23.
//

import SwiftUI

/// ContentView creates instance of #AllProductsView and #FavouritesView by injecting view model
/// TabView is created to display AllProductsView, FavouritesView as 2 tabs
/// onAppear - Making network call and loading data to AllProductsView and FavouritesView
///
struct ContentView: View {
    @ObservedObject var viewModel: WineGalleryViewModel

    var body: some View {
        TabView {
            AllProductsView(viewModel: viewModel)
                .tabItem {
                    Label("All Products", systemImage: "list.bullet")
                }
            FavouritesView(viewModel: viewModel)
                .tabItem {
                    Label("Favourites", systemImage: "text.badge.star")
                }
        }
        .onAppear {
            viewModel.handle(.refresh)
        }
    }
}

/// Using ContentView_Previews, we can preview complete application by changing appClient value
/// EX: .live - This will fetch live data and show in preview view
/// .fakeError - This will simulate error case when data is not available
/// .fakeSuccess - This will fake the success.

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            viewModel: WineGalleryViewModel(
                appClient: .live
            )
        )
    }
}
