//
//  State.swift
//  WineGallery
//
//  Created by Anilkumar on 21/02/23.
//

import Foundation

/// Enum holds Gallery State
enum GalleryState: Equatable {
    ///Data fetching from anytype of source, this represents initial state. We can use this state to show loading indicator
    case loading
    
    ///Data fetching failed with Error. We can use this state to show Error Message
    case error

    ///This enum represents success case, we are able to fetch data. We can use this state to update UI elements
    case products([ProductInfo])
}

/// GalleryState enum extension

extension GalleryState {
    ///This var will returns empty product array, this will be usfel for stubbbing and testing
    static var empty: Self {
        .products([])
    }
    ///This var will returns dummys array of product, this will be usfel for unit testing
    static var dummys: Self {
        .products([.dummy, .dummy, .dummy])
    }
}
