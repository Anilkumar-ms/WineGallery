//
//  WineGalleryViewModel.swift
//  WineGallery
//
//  Created by Anilkumar on 21/02/23.
//

import Foundation
import Combine

///WineGalleryViewModel - This =view model is responsible for all the business logic of AllProductsView and FavouritesView
class WineGalleryViewModel: ObservableObject {
    @Published var state: GalleryState = .loading

    private let appClient: AppClient

    private var refreshCancellable: AnyCancellable?

    init(appClient: AppClient) {
        self.appClient = appClient
    }
    /// updateProductInfo - This function will update favourite state based on the parameter provided.
    /// - Parameters:
    /// - info:ProductInfo contains product info we need to update
    /// - isFavourite : Based on this boolean isFavourite value will be updated.
    private func updateProductInfo(_ info: inout ProductInfo, isFavourite: Bool) {
        info.isFavourite = isFavourite
    }
    
    /// refreshProducts - This function will refresh the data
    private func refreshProducts() {
        refreshCancellable = appClient.products()
            .sink { [weak self] completionResult in
                switch completionResult {
                case .failure: self?.state = .error
                case .finished: ()
                }
            } receiveValue: { [weak self] products in
                self?.state = .products(products.map { ProductInfo(product: $0) })
            }
    }
}

extension WineGalleryViewModel {
    //TODO - improvement, this can be seperated as eventHandler
    ///handle - This is actually a Event handler, acts based on action data provided
    ///- Parameters:
    ///action - Based on the MainAction, event will get triggered
    func handle(_ action: MainAction) {
        switch action {
        case .refresh:
            state = .loading
            refreshProducts()
        case .markFavourite(let info), .unmarkFavourite(let info):
            guard case .products(var productInfos) = state else { return }
            productInfos
                .firstIndex(of: info)
                .map { updateProductInfo(&productInfos[$0], isFavourite: !info.isFavourite) }
            state = .products(productInfos)
            return
        case .update(let updatedProductInfo):
            guard case .products(var productInfos) = state else { return }
            productInfos
                .firstIndex(where: { $0.id == updatedProductInfo.id })
                .map { productInfos[$0] = updatedProductInfo }
            state = .products(productInfos)
        }
    }
}
