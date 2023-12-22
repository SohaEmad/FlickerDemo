//
//  Netwrok.swift
//  FlickrApp
//
//  Created by Soha Ahmed on 17/12/2023.
//

import SwiftUI
import Foundation
import CoreLocation

class Network {
    
    func getPhotosData(searchText: String, useUserId: String, pageCount: Int, allTags: Bool, location: CLLocation? = nil) async throws -> Data? {
        guard let url = buildGetPhotosUrl(searchText: searchText, useUserId: useUserId, pageCount: pageCount, allTags: allTags, location: location) else {
            return nil
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response =  response as? HTTPURLResponse, response.statusCode == 200 else {
                throw RetreiveError.invalidresponse
            }
            return data
        } catch {
            throw RetreiveError.invalidData
        }
    }
    
    func getUserData(userUrl : String) async throws -> Data? {
        guard  let url = URL(string: "\(Constatnts.FLICKR_GET_USER)&url=\(userUrl)&\(Constatnts.FORMAT)") else {
            return nil
        }
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response =  response as? HTTPURLResponse, response.statusCode == 200 else {
                throw RetreiveError.invalidURL
            }
            return data
        } catch {
            throw RetreiveError.invalidData
        }
    }
    
    
    func getUserId(userUrl: String) async throws -> User? {
        do {
            guard let data = try await self.getUserData(userUrl: userUrl) else {
                return nil
            }
            let decoder = JSONDecoder()
            let userResponse =  try decoder.decode(UserResponse.self, from: data)
            return userResponse.user
        }
        catch {
            throw RetreiveError.invalidresponse
        }
    }
    
    
    func getPhotos(searchText: String, UserId: String, pageCount: Int, allTags: Bool = false, location: CLLocation? = nil) async throws -> [Photo] {
        do {
            guard let data = try? await self.getPhotosData(searchText: searchText, useUserId: UserId, pageCount: pageCount, allTags: allTags, location: location) else {
                return []
            }
            let decoder = JSONDecoder()
            let response =  try decoder.decode(Response.self, from: data)
            if response.photos.total > 0 {
                return response.photos.getValidPhotos()
            }
        }
        catch {
            throw RetreiveError.invalidresponse
        }
        return []
    }
    
    
    private func buildGetPhotosUrl(searchText: String, useUserId: String, pageCount: Int, allTags: Bool = false, location: CLLocation? = nil) -> URL? {
        var _searchText = searchText
        if( searchText.isEmpty) {
            _searchText = Constatnts.DEFAULT_SEARCH_TEXT
        }
        var text = _searchText.components(separatedBy: ",")
        if(text.count > 1){
            _searchText = text[text.count-1].trimmingCharacters(in: .whitespacesAndNewlines);
            text.removeLast()
        } else {
            _searchText = text[0].trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if useUserId != "" {
            let userIdEncoded = useUserId.urlEncoded ?? ""
            return URL(string:
                        "\(Constatnts.FLICKR_GET_PHOTOS)&user_id=\(userIdEncoded)&tag_mode=any&\(Constatnts.EXTRAS)&page=\(pageCount)&\(Constatnts.FORMAT)")
        }
        
        let tags = "&tags=\(_searchText.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)"
        let locationString = location != nil ? "lat=\(location?.coordinate.latitude ?? 0.44 )&lon=\(location?.coordinate.longitude ?? 51.32 )&" : ""
        return URL(string: "\(Constatnts.FLICKR_GET_PHOTOS)\(tags)&\(Constatnts.EXTRAS)&page=\(pageCount)&tag_mode=\(allTags ? "all" : "any")&\(locationString)\(Constatnts.FORMAT)")
    }
    
    
    enum RetreiveError: Error {
        case invalidURL
        case emptyReturn
        case invalidresponse
        case invalidData
    }
    
}
