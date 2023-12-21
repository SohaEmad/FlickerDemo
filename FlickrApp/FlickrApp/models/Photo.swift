//
//  Photo.swift
//  FlickrApp
//
//  Created by Soha Ahmed on 12/12/2023.
//

public struct Photo: Codable, Identifiable{
    
    public var id: String = ""
    var owner: String = ""
    var secret: String = ""
    var server: String = ""
    var farm: Int = 0
    var title: String = ""
    var ispublic: Int = 0
    var isfriend: Int = 0
    var isfamily: Int = 0
    var url_l: String?
    var height_l: Int?
    var width_l: Int?
    var datetaken: String = ""
    var ownername: String?
    var description: Description?
    var tags: String?
    
    
    /**
     get all or certain number of tags of a certain photo
     - Parameters : maxLength : the maximum number of tags to be retruned
     - Returns: an array of string that include the photo tags the maximum length of maxLength or tags array length
     */
    func getTags(_ maxLength: Int? = nil)-> [String]{
        let allTags = (tags?.components(separatedBy: " ").filter({ $0 != ""}) ?? []).sorted { $0.count < $1.count}
        guard let length = maxLength else {
            return allTags
        }
        return allTags.count > length ? Array(allTags[0...length]) : allTags
    }
    
    func getDate() -> String {
        return datetaken.components(separatedBy: " ").first ?? " "
    }
}

public struct Description: Codable {
    var _content: String?
}
