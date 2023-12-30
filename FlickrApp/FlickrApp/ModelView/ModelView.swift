//
//  Network.swift
//  Flickr
//
//  Created by Soha Ahmed on 08/12/2023.
//

import Foundation
import CoreLocation

class ModelView: ObservableObject {
    
    @Published var searchText: String = "Yorkshire"
    @Published var user: User?
    @Published var userName : String = Constatnts.DEFAULT_USER
    var userUrl: String = ""
    @Published var photos: [Photo] = []
    @Published var userID = ""
    private var pageCount = 1
    private var network: Network
    @Published var allTags = false   
    @Published var location: CLLocation? 
    
    init(){
        network = Network()
        userUrl = Constatnts.USER_URL + userName
        
    }
    
    /**
     get user ID using the currently defeined user name
     */
    
    @MainActor func getUserID() {
        userUrl = Constatnts.USER_URL + userName
        Task{
            do {
                guard let newUser = try await self.network.getUserId(userUrl: userUrl) else {
                    return
                }
                self.user = newUser
                user?.profilePhoto = String(format: Constatnts.PROFILE_PHOTO, user?.id ?? Constatnts.USER_ID)
            }
            catch {
                throw RetreiveError.invalidresponse
            }
        }
        self.userID = user?.id ?? Constatnts.USER_ID
    }
    
    
    /**
     get  search words based list of photos
     
     - Parameters:
     useUserId: Boolean that define if the photos will use user Id filter or not
     allTags: Boolean that define if all tags should be considered in the search or not
     location: a CLocation instance make the photo search location dependent by default nil
     useSearchTags: a Boolean that deceid if the get  photo by tag or just recent photos
     */
    @MainActor func getPhotos(useUserId: Bool = false, allTags: Bool = false, location: CLLocation? = nil, useSearchTags: Bool = false) {
        Task{
            do {
                guard let newPhotos = try? await self.network.getPhotos(searchText: useSearchTags ? searchText : "", UserId: useUserId ? userID : "", pageCount: pageCount, allTags: allTags, location: location) else {
                    return
                }
                self.photos.append(contentsOf: newPhotos)
            }
        }
    }
    
    func reset() {
        self.photos.removeAll()
    }
    
    
    @MainActor func getPhotosBy(location: CLLocation) {
        Task{
            do {
                guard let newPhotos = try? await self.network.getPhotos(searchText: searchText, UserId: "", pageCount: pageCount) else {
                    return
                }
                self.photos.append(contentsOf: newPhotos)
            }
        }
    }
    
    /**
     a function that provids endless scroll view functionaliy by loading more photos once the user reached the end of the scroll view
     */
    
    @MainActor func loadMorePhotos(usingUserId: Bool = false) {
        pageCount += 1
        getPhotos(useUserId: usingUserId)
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
