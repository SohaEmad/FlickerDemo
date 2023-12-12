//
//  Network.swift
//  Flicker
//
//  Created by Soha Ahmed on 08/12/2023.
//

import Foundation

class ModelView: ObservableObject {
    
    @Published var searchText: String = "Yorkshire"
    @Published var user: User?
    @Published var userUrl: String = "https://www.flickr.com/photos/dswindler/"
    @Published var photos: [Photo] = []
    private var pageCount = 1
    
    func buildUrl(searchText: String, userID:String = "") -> URL? {
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
        
        let safeText = _searchText.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let safeCat = _cat.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        return  URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=f46b7b3920dc5855bdfdbeacd14b3ebd&safe_search=safe&user_id=\(userID)&tags=\(safeCat)&text=\(safeText)&privacy_filter=1&content_type=1&extras=url_s%2C+url_o%2C+url_t%2C+url_m%2C+url_l%2C+description%2C+tags&per_page=20&page=\(pageCount)&format=json&nojsoncallback=1")
    }
    
    @MainActor  func getUserID() -> String {
        let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.urls.lookupUser&api_key=f46b7b3920dc5855bdfdbeacd14b3ebd&url=\(userUrl)&format=json&nojsoncallback=1")!
        print(url)
        Task{
            do{
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let response =  response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw RetreiveError.invalidresponse
                }
                do {
                    let decoder = JSONDecoder()
                    print(String(data: data, encoding: .utf8))
                    user =  try decoder.decode(User.self, from: data)
                    user?.profilePhoto = "https://farm9.staticflickr.com/8573/buddyicons/\(user?.id ?? "38945681@N07")_l.jpg" 
                    print(user?.profilePhoto)
                }
                catch let error {
                    print(error)
                }
            } catch let error{
                print(error)
            }
        }
        return ""
    }
    
    
    @MainActor func getPhotos() {
        guard let url = buildUrl(searchText: searchText) else {
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
                        photos = response.photos.photo
                    }
                }
                catch let error {
                    print(error)
                }
            } catch let error {
                print(error)
            }
        }
    }
    
    @MainActor func loadMorePhotos() {
        pageCount += 1
        getPhotos()
    }
}




enum RetreiveError: Error{
    case invalidURL
    case emptyReturn
    case invalidresponse
    case invalidData
}

