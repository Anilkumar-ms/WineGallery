//
//  ProductListView.swift
//  WineGallery
//
//  Created by Anilkumar on 21/02/23.
//

import SwiftUI

///ProductListView - This View will display complete List of Products
struct ProductListView: View {
    let productInfos: [ProductInfo]
    @ObservedObject var viewModel: WineGalleryViewModel

    var body: some View {
        VStack {
            List {
                ForEach(productInfos) { info in
                    NavigationLink {
                        DetailProductView(
                            viewModel: .init(
                                productInfo: info,
                                pushBack: { updatedInfo in
                                    viewModel.handle(.update(updatedInfo))
                                }
                            )
                        )
                    } label: {
                        ProductRowView(viewModel: viewModel, info: info)
                    }
                }
            }
        }
    }
}

///ProductListView - This View represents individula row of ProductListView

struct ProductRowView: View {
    @ObservedObject var viewModel: WineGalleryViewModel
    let info: ProductInfo

    var body: some View {
        HStack {
            if let url = info.product.imageURL {
                AsyncImage(imageURL: url)
                .frame(width: 30, height: 30)
                .padding(.vertical)
            }
            info.product.title.map { Text($0) }
            Spacer()
            Button {
                withAnimation {
                    viewModel.handle(info.isFavourite ? .unmarkFavourite(info) :.markFavourite(info))
                }
            } label: {
                switch info.isFavourite {
                case true: Image(systemName: "star.fill")
                case false: Image(systemName: "star")
                }
            }
            .buttonStyle(.plain)
            .fixedSize()
            .frame(width: 30, height: 30)
        }
    }
}
