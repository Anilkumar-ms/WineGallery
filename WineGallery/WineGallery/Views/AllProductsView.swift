//
//  AllProductsView.swift
//  WineGallery
//
//  Created by Anilkumar on 21/02/23.
//

import SwiftUI

///AllProductsView - This View basically takes care of getting data and loading data into ProductListView.

struct AllProductsView: View {
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
                    ProductListView(productInfos: products, viewModel: viewModel)
                }
            }
            .navigationTitle("Wines")
                .toolbar {
                    Button("Refresh") {
                        viewModel.handle(.refresh)
                    }
                }
        }
    }
}
