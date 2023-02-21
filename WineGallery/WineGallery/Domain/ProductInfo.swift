//
//  ProductInfo.swift
//  WineGallery
//
//  Created by Anilkumar on 21/02/23.
//

import Foundation
///ProductInfo - this basically holds product information of each product
struct ProductInfo: Identifiable, Equatable {
    let id: UUID = UUID()
    /// product -  Constant holds #Product information
    let product: Product
    ///isFavourite : This boolean indicated whether this product is marked as Favourite or not.
    var isFavourite: Bool = false
}

extension ProductInfo {
    ///dummy - This creates dummy data for our unit testing purpose
    static var dummy: Self {
        .init(product: .dummy)
    }
}
