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
    @Published var userName : String = Constatnts.DEFAULT_USER
    var userUrl: String = ""
    @Published var photos: [Photo] = []
    @Published var userID = ""
    private var pageCount = 1
    private var network: Network
    
    init(){
        network = Network()
    }
    
    /**
     get user ID using the currently defeined user name
     */
    
    @MainActor func getUserID() {
        Task{
            do {
                guard let newUser = try await self.network.getUserId(userName: userName) else {
                    return
                }
                self.user = newUser
                user?.profilePhoto = String(format: Constatnts.PROFILE_PHOTO, user?.id ?? Constatnts.USER_ID)
                print(user?.profilePhoto)
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
     useUserId: a Boolean that define if the photos will use user Id filter or not
     */
    @MainActor func getPhotos(useUserId: Bool = false) {
        Task{
            if useUserId == true {
                self.getUserID()
            }
            do {
                guard let newPhotos = try? await self.network.getPhotos(searchText: searchText, UserId: useUserId ? userID : "", pageCount: pageCount) else {
                    return
                }
                self.photos = newPhotos
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


