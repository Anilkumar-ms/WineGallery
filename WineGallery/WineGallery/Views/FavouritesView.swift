//
//  FavouritesView.swift
//  WineGallery
//
//  Created by Anilkumar on 21/02/23.
//

import SwiftUI

///FavouritesView - This View will display List of all Favourite Products
struct FavouritesView: View {
    @ObservedObject var viewModel: WineGalleryViewModel

    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .loading:
                    Text("Loading..")
                case .error:
                    Text("Retry once again please.")
                case .products(let products):
                    ProductListView(
                        productInfos: products.filter { $0.isFavourite },
                        viewModel: viewModel
                    )
                }
            }
            .navigationTitle("Favourites")
                .toolbar {
                    Button("Refresh") {
                        viewModel.handle(.refresh)
                    }
                }
        }
    }
}
