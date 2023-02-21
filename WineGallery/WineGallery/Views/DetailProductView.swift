//
//  DetailProductView.swift
//  WineGallery
//
//  Created by Anilkumar on 21/02/23.
//

import SwiftUI
///DetailProductView - This View will display complete Product information in much detailed format
struct DetailProductView: View {
    ///viewModel - Injected view model from List View
    @ObservedObject var viewModel: WineDetailViewModel
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loaded(let info):
                VStack(spacing: 30) {
                    info.product.title.map { Text("Name : \($0)") }
                        .font(.largeTitle)
                        .padding()
                    HStack {
                        if let url = info.product.imageURL {
                            GeometryReader { proxy in
                                AsyncImage(imageURL: url)
                                .fixedSize()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200, alignment: .leading)
                            }
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Favourite:")
                                    .padding(.leading)
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
                            }
                            Spacer()
                            Text("Rating: \(info.product.ratingCount ?? 0.0)")
                                .padding()
                            Text("Brand: \(info.product.brand ?? "NA")")
                                .padding()
                            Text("Price: \(info.product.price?.first?.value ?? 0.0)")
                                .font(.headline)
                                .padding()
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Text("Price Lot: \(info.product.price?.first?.message.capitalized ?? "")")
                        .padding()
                    Text("Review Count: \(info.product.totalReviewCount ?? 0)")
                        .padding()
                    Spacer()
                }
            }
        }
        .onDisappear{
            ///onDisappear - callback to inform calling view to update the data based on updated DetailViewdata
            viewModel.handle(.back)
        }
    }
}
