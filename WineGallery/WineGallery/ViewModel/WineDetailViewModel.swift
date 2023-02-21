//
//  WineDetailViewModel.swift
//  WineGallery
//
//  Created by Anilkumar on 21/02/23.
//

import Foundation

typealias ProductInfoPushBack = (ProductInfo) -> Void
/// DetailState - This defines the state details of WineDetailView
enum DetailState: Equatable {
    ///loaded : since data is already provide by FavouritesView/AllProductsView, this contains only one state loaded
    ///This can be easily extended if we need to handle more states
    case loaded(ProductInfo)
}

class WineDetailViewModel: ObservableObject {
    @Published var state: DetailState

    var pushBack: ProductInfoPushBack
    ///init - initilizer to initilize productInfo, pushBack
    ///- Parameters:
    /// productInfo - Productinformation need to display in details view
    /// pushBack - closure to push updated to calling view
    init(productInfo: ProductInfo, pushBack: @escaping ProductInfoPushBack) {
        self.state = .loaded(productInfo)
        self.pushBack = pushBack
    }
}

extension WineDetailViewModel {
    //TODO - improvement, this can be seperated as eventHandler
    ///handle - This is actually a Event handler, acts based on action data provided
    ///- Parameters:
    ///action - Based on the DetailAction, event will get triggered
    func handle(_ action: DetailAction) {
        switch action {
        case .markFavourite(let info), .unmarkFavourite(let info):
            guard case .loaded(var productInfo) = state else { return }
            updateProductInfo(&productInfo, isFavourite: !info.isFavourite)
            state = .loaded(productInfo)
            return
        case .back:
            guard case .loaded(let productInfo) = state else { return }
            self.pushBack(productInfo)
        }
    }
    
    /// updateProductInfo - This function will update favourite state based on the parameter provided.
    /// - Parameters:
    /// - info:ProductInfo contains product info we need to update
    /// - isFavourite : Based on this boolean isFavourite value will be updated.
    private func updateProductInfo(_ info: inout ProductInfo, isFavourite: Bool) {
        info.isFavourite = isFavourite
    }
}
