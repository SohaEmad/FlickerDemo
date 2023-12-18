//
//  Netwrok.swift
//  FlickrApp
//
//  Created by Soha Ahmed on 17/12/2023.
//

import SwiftUI
import Foundation

class Network {
    
    func getPhotosData(searchText: String, useUserId: String, pageCount: Int) async throws -> Data? {
        guard let url = buildGetPhotosUrl(searchText: searchText, useUserId: useUserId, pageCount: pageCount) else {
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
        catch let error{
            print(error)
            throw RetreiveError.invalidresponse
        }
    }
    
    
    func getPhotos(searchText: String, UserId: String, pageCount: Int) async throws -> [Photo] {
        do {
            guard let data = try? await self.getPhotosData(searchText: searchText, useUserId: UserId, pageCount: pageCount) else {
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
    
    
    
    private func buildGetPhotosUrl(searchText: String, useUserId: String, pageCount: Int) -> URL? {
        var _searchText = searchText
        if( searchText.isEmpty) {
            return nil;
        }
        var text = _searchText.components(separatedBy: ",")
        var _cat = "";
        if(text.count > 1){
            _searchText = text[text.count-1].trimmingCharacters(in: .whitespacesAndNewlines);
            text.removeLast()
            _cat = text.joined(separator: ",")
        } else {
            _searchText = text[0].trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if useUserId != "" {
            let userIdEncoded = useUserId.urlEncoded ?? ""
            return URL(string: "\(Constatnts.FLICKR_GET_PHOTOS)&user_id=\(userIdEncoded)&\(Constatnts.EXTRAS)&page=\(pageCount)&\(Constatnts.FORMAT)")
        }
        
        let safeText = "&text=\(_searchText.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)"
        let tags = "&tags=\(_cat.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)"
        return URL(string: "\(Constatnts.FLICKR_GET_PHOTOS)\(tags)\(safeText)&\(Constatnts.EXTRAS)&page=\(pageCount)&\(Constatnts.FORMAT)")
    }
    
    
    enum RetreiveError: Error {
        case invalidURL
        case emptyReturn
        case invalidresponse
        case invalidData
    }
    
}
