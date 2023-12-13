//
//  Network.swift
//  Flickr
//
//  Created by Soha Ahmed on 08/12/2023.
//

import Foundation

class ModelView: ObservableObject {
    
    @Published var searchText: String = "Yorkshire"
    @Published var user: User?
    @Published var userUrl: String = "https://www.flickr.com/photos/dswindler/"
    @Published var photos: [Photo] = []
    @Published var userID = ""
    private var pageCount = 1
    
    
    @MainActor func getUserID() {
        let url = URL(string: "\(Constatnts.FLICKR_GET_USER)&url=\(userUrl)&\(Constatnts.FORMAT)")!
        Task{
            do{
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let response =  response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw RetreiveError.invalidURL
                }
                do {
                    let decoder = JSONDecoder()
                    user =  try decoder.decode(User.self, from: data)
                    user?.profilePhoto = String(format: Constatnts.PROFILE_PHOTO, user?.id ?? Constatnts.USER_ID)
                }
                catch {
                    throw RetreiveError.invalidresponse
                }
            } catch {
                throw RetreiveError.invalidData
            }
        }
        self.userID = user?.id ?? Constatnts.USER_ID
    }
    
    
    @MainActor func getPhotos(useUserId: Bool = false) {
        guard let url = buildUrl(searchText: searchText, useUserId: useUserId) else {
            return
        }
        Task{
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                
                guard let response =  response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw RetreiveError.invalidresponse
                }
                do {
                    let decoder = JSONDecoder()
                    let response =  try decoder.decode(Response.self, from: data)
                    if response.photos.total > 0 {
                        photos = response.photos.getValidPhotos()
                    }
                }
                catch {
                    throw RetreiveError.invalidresponse
                }
            } catch {
                throw RetreiveError.invalidData
            }
        }
    }
    
    @MainActor func loadMorePhotos(usingUserId: Bool = false) {
        pageCount += 1
        getPhotos(useUserId: usingUserId)
    }
    
    private func buildUrl(searchText: String, useUserId: Bool) -> URL? {
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
        
        if useUserId {
            let userIdEncoded = Constatnts.USER_ID.urlEncoded ?? ""
            return URL(string: "\(Constatnts.FLICKR_GET_PHOTOS)&user_id=\(userIdEncoded)&\(Constatnts.EXTRAS)&page=\(pageCount)&\(Constatnts.FORMAT)")
        }
        
        let safeText = "&text=\(_searchText.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)"
        let tags = "&tags=\(_cat.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)"
        return URL(string: "\(Constatnts.FLICKR_GET_PHOTOS)\(tags)\(safeText)&\(Constatnts.EXTRAS)&page=\(pageCount)&\(Constatnts.FORMAT)")
    }
}

enum RetreiveError: Error {
    case invalidURL
    case emptyReturn
    case invalidresponse
    case invalidData
}

extension String {
    var urlEncoded: String? {
        let allowedCharacterSet = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "@~-_."))
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
    }
}
