//
//  UserResponse.swift
//  Flickr
//
//  Created by Soha Ahmed on 12/12/2023.
//

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
