//
//  FlickerResponse.swift
//  Flicker
//
//  Created by Soha Ahmed on 08/12/2023.
//

import Foundation
import UIKit

/// the main json structure of 

struct Response: Codable {
    var photos: Photos
    var stat: String
}

struct Photos: Codable{
    var page: Int = 1
    var pages: Int = 1
    var perpage: Int = 12
    var total: Int = 12
    var photo: [Photo]
    
    func getValidPhotos() -> [Photo] {
        return photo.filter  {
            verifyUrl(urlString:$0.url_l)
        }
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
}


