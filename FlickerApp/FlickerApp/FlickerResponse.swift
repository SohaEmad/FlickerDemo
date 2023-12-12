//
//  FlickerResponse.swift
//  Flicker
//
//  Created by Soha Ahmed on 08/12/2023.
//

import Foundation

struct Response: Codable {
    var photos: Photos
    var stat: String
}

struct Page {
    var page: Int = 1
    var pages: Int = 1
    var perpage: Int = 12
    var total: Int = 12
}

struct Photos: Codable{
    var page: Int = 1
    var pages: Int = 1
    var perpage: Int = 12
    var total: Int = 12
    var photo: [Photo]
}

struct Photo: Codable, Identifiable, Hashable{
    var id: String
    var owner: String
    var secret: String
    var server: String
    var farm: Int
    var title: String
    var ispublic: Int
    var isfriend: Int
    var isfamily: Int
    var url_s: String?
    var height_s: Float?
    var width_s: Float?
    var url_o: String?
    var height_o: Int?
    var width_o: Int?
    var url_t: String?
    var height_t: Float?
    var width_t: Float?
    var url_m: String?
    var height_m: Int?
    var width_m: Int?
    var url_l: String?
    var height_l: Int?
    var width_l: Int?
    var desciption: String?
    var tags: String?
    
    func getTags(_ maxLength: Int? = nil)-> [String]{
        let allTags = tags?.components(separatedBy: " ").filter({ $0 != ""}) ?? [] .sorted{
            $0.count < $1.count
        }
        guard let length = maxLength else {
            print(allTags)
            return allTags
        }
        return allTags.count > length ? Array(allTags[0...length]) : allTags
    }
}

struct UserResponse: Codable {
    var user: User
    var stat: String

}
struct User: Codable {
    var id: String?
    var username: UserName?
    var profilePhoto: String?
}

struct UserName: Codable {
    var _content: String?
}
