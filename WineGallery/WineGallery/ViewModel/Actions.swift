//
//  Actions.swift
//  WineGallery
//
//  Created by Anilkumar on 21/02/23.
//

import Foundation

/// MainAction defines all the actions invloved in ProductListView/FavouritesView
/// Currently i have added cases based on current functionality, can be extended easily to support new actions

enum MainAction {
    ///refresh - New request is made to server to get updated data. This case will be called when we need to refresh data/ get updated data from any server.
    case refresh
    
    ///markFavourite - This action will mark ProductInfo as Favourite
    ///- Parameters:ProductInfo
    ///This contains ProductInfo object that need to marked as Favourite
    case markFavourite(ProductInfo)

    ///unmarkFavourite - This action will remove @ProductInfo from Favourite
    ///- Parameters:ProductInfo
    ///This contains ProductInfo object that need to removed as Favourite
    case unmarkFavourite(ProductInfo)

    ///update - This action will update current ProductInfo data to updated ProductInfo Data
    ///- Parameters:ProductInfo
    ///This contains updated ProductInfo object, based on this ProductInfo we need to update our ProductInfo
    case update(ProductInfo)
}
