//
//  AsyncImage.swift
//  WineGallery
//
//  Created by Anilkumar on 21/02/23.
//

import SwiftUI

///AsyncImage - This View provides option to load image from URL
///If request is already present in cache it picks from Cache
struct AsyncImage: View {
    
    @ObservedObject var imageLoader: ImageLoaderAndCache

    init(imageURL: String) {
        imageLoader = ImageLoaderAndCache(imageURL: imageURL)
    }

    var body: some View {
          Image(uiImage: UIImage(data: self.imageLoader.imageData) ?? UIImage())
              .resizable()
              .clipped()
    }
}

class ImageLoaderAndCache: ObservableObject {
    
    @Published var imageData = Data()
    
    init(imageURL: String) {
        downloadImageFromURL(imageURL)
    }
  ///This function takes URL as parameter, if URL is valid then we will download the image using NSURLSession.
    ///If Request already present in Cache, instead of hitting request to server, we will pick image from Cache.
    ///- Parameters:url - image URL from where we need to download image
    func downloadImageFromURL(_ url: String) {
        let cache = URLCache.shared
        if let url = URL(string: url) {
                let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 30.0)
                if let data = cache.cachedResponse(for: request)?.data {
                    self.imageData = data
                } else {
                    URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                        if let data = data, let response = response {
                            let cachedData = CachedURLResponse(response: response, data: data)
                            cache.storeCachedResponse(cachedData, for: request)
                            DispatchQueue.main.async {
                                self.imageData = data
                            }
                        }
                    }).resume()
                }
            }
    }
}
