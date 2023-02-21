//
//  WineDetailGalleryTests.swift
//  WineGalleryTests
//
//  Created by Anilkumar on 21/02/23.
//

import XCTest

@testable import WineGallery

final class WineDetailGalleryTests: XCTestCase {
    
    func testItShouldNotHaveRetainCycle() throws {
        weak var weakVCReference: WineDetailViewModel?
        autoreleasepool {
            let strongVCReference = WineDetailViewModel(productInfo: ProductInfo(product: .dummy)) { productInfo in }
            weakVCReference = strongVCReference
            XCTAssertNotNil(weakVCReference)
        }
        XCTAssertNil(weakVCReference)
    }
    
    func testItShouldHaveLoadedStateInitially() throws {
        let productInfo = ProductInfo(product: .dummy)
        let sut = WineDetailViewModel(productInfo: productInfo) { productInfo in }
        XCTAssertEqual(sut.state, .loaded(productInfo))
    }
    
    func testItProductInfoPushBackSuccess() throws {
        let sut = WineDetailViewModel(productInfo: .dummy) { productInfo in }
        let exp = expectation(description: "PushBackClosure")

        sut.pushBack = { productInfo in
            exp.fulfill()
        }
        
        sut.handle(.back)
        waitForExpectations(timeout: 3)
    }
}
