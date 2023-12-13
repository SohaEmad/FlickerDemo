//
//  FlickerAppTests.swift
//  FlickerAppTests
//
//  Created by Soha Ahmed on 08/12/2023.
//

import XCTest
@testable import FlickerApp

final class FlickerAppTests: XCTestCase {

    var response: Response? = nil
    
    override func setUpWithError() throws {
        let bundle = Bundle(for: type(of: self))
        
        let validResponse = bundle.url(forResource: "validPhotoResponse", withExtension: "json")!
        let data = try! Data(contentsOf: validResponse)
        
        let decoder = JSONDecoder()
        response = try decoder.decode(Response.self, from: data)
    }
    func testStringValueDecodedSuccessfully() throws {
        XCTAssertEqual(response?.stat, "ok")
        XCTAssertEqual(response?.photos.photo.count, 1)
        XCTAssertEqual(response?.photos.photo[0].title, "Cat Paws")
    }
    
    func testGettingTags() throws {
        let photo = response?.photos.photo[0]
        XCTAssertEqual(photo?.getTags(2).count, 3)
        XCTAssertEqual(photo?.getTags().count, 8)
        XCTAssertEqual(photo?.getTags()[0], "catlife")
    }

}
