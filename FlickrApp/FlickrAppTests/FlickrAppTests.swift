//
//  FlickrAppTests.swift
//  FlickrAppTests
//
//  Created by Soha Ahmed on 08/12/2023.
//

import XCTest
import Combine
import SwiftUI
@testable import FlickrApp

final class FlickrAppTests: XCTestCase {
    
    var network = MockNetwork()
    var photos: [Photo] = []
    var user: User?
    
    @MainActor override func setUp() async throws {
        user =  try await network.getUserId(userName: "https://www.flickr.com/photos/dswindler/")
        photos = try await network.getPhotos(searchText: "", UserId: "", pageCount: 0)
    }
    
    func testPhotoDecodedSuccessfully() {
        XCTAssertEqual(photos.count, 1)
        XCTAssertEqual(photos[0].title, "Cat Paws")
    }
    
    func testGettingTags() {
        XCTAssertEqual(photos[0].getTags(2).count, 3)
        XCTAssertEqual(photos[0].getTags().count, 8)
        XCTAssertEqual(photos[0].getTags()[0], "cat")
    }
    
    func testUserDecodedSuccessfully()  {
        XCTAssertEqual(user?.id, "38945681@N07")
        XCTAssertEqual(user?.username?._content, "David Swindler (ActionPhotoTours.com)")
    }
}
