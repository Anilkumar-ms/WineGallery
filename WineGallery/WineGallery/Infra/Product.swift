//
//  Product.swift
//  WineGallery
//
//  Created by Anilkumar on 21/02/23.
//

import Foundation

struct Product: Decodable, Equatable {
    let id: String

    let citrusId: String?

    let title: String?

    let imageURL: String?

    let price : [Price]?

    let brand: String?

    let badges: [String]?
    
    let ratingCount: Float?
    
    let totalReviewCount: Int?


    struct Price: Decodable, Equatable {
        let message: String

        let value: Float

        let isOfferPrice: Bool
    }

    init(
        id: String,
        citrusId: String? = nil,
        title: String? = nil,
        imageURL: String? = nil,
        price: [Price]? = nil,
        brand: String? = nil,
        badges: [String]? = nil,
        ratingCount: Float? = 0.0,
        totalReviewCount: Int? = 0
    ) {
        self.id = id
        self.citrusId = citrusId
        self.title = title
        self.imageURL = imageURL
        self.price = price
        self.brand = brand
        self.badges = badges
        self.ratingCount = ratingCount
        self.totalReviewCount = totalReviewCount
    }
}

extension Product {
    static var dummy: Self {
        .init(id: "someID", title: "Dummy Product")
    }
}
