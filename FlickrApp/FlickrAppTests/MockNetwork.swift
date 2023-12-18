//
//  MockNetwork.swift
//  FlickrApp
//
//  Created by Soha Ahmed on 17/12/2023.
//

import Foundation
@testable import FlickrApp

class MockNetwork: Network {
    
    let bundle: Bundle
    
    override init()  {
        self.bundle = Bundle(for: type(of: self))
    }
    override func getPhotosData(searchText: String, useUserId: String, pageCount: Int) async throws -> Data? {
        let validResponse = bundle.url(forResource: "validPhotoResponse", withExtension: "json")!
        return try? Data(contentsOf: validResponse)
    }
    
    func getUserData(userUrl : String) -> Data? {
        let validResponse = bundle.url(forResource: "UserResponse", withExtension: "json")!
        return try? Data(contentsOf: validResponse)
    }
    
    
    
    
}
