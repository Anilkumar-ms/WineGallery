//
//  WineGalleryTests.swift
//  WineGalleryTests
//
//  Created by Anilkumar on 21/02/23.
//

import XCTest
@testable import WineGallery

@testable import WineGallery

final class WineGalleryTests: XCTestCase {

    func testItShouldNotHaveRetainCycle() throws {
        weak var weakVCReference: WineGalleryViewModel?
        autoreleasepool {
            let strongVCReference = WineGalleryViewModel(appClient: .fakeError)
            weakVCReference = strongVCReference
            XCTAssertNotNil(weakVCReference)
        }
        XCTAssertNil(weakVCReference)
    }

    func testItShouldHaveLoadingStateInitially() throws {
     let sut = WineGalleryViewModel(appClient: .fakeSuccess)
        XCTAssertEqual(sut.state, .loading)
    }

    func testItShouldSetErrorStateWhenNetworkMalfuntions() throws {
      let sut = WineGalleryViewModel(appClient: .fakeError)
        sut.handle(.refresh)
        XCTAssertEqual(sut.state, .error)
    }

    func testItShouldHaveProductsWhenSuccess() throws {
        let sut = WineGalleryViewModel(appClient: .fakeSuccess)
        sut.handle(.refresh)
        guard case .products(let infos) = sut.state else { return XCTFail("System in volatile state.") }
        let frozenTitles = infos.map { $0.product.title }
        let expectedTitles = ["Dummy Product", "Dummy Product", "Dummy Product"]
        XCTAssertEqual(frozenTitles, expectedTitles)
    }

    func testItShouldUnMarkFavourite() throws {
        let sut = WineGalleryViewModel(appClient: .fakeSuccess)
        sut.handle(.refresh)
        guard case .products(let infos) = sut.state else { return XCTFail("System in volatile state.") }
        let previousState = infos[0].isFavourite
        sut.handle(.unmarkFavourite(infos[0]))
        guard case .products(let infos) = sut.state else { return XCTFail("System in volatile state.") }
        XCTAssertNotEqual(infos[0].isFavourite, previousState)
    }
}

extension XCTestCase {
    func wait(for waitTime: TimeInterval, message: String, testFor assertBlock: @escaping ()-> Void) {
        let fetchedExpectation = expectation(description: message)
        defer { wait(for: [fetchedExpectation], timeout: waitTime + 0.05) }
        DispatchQueue.main.asyncAfter(deadline: .now() + waitTime) {
            fetchedExpectation.fulfill()
            assertBlock()
        }
    }
}
