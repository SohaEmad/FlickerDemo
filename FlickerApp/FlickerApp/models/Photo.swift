//
//  Photo.swift
//  FlickerApp
//
//  Created by Soha Ahmed on 12/12/2023.
//

public struct Photo: Codable, Identifiable, Hashable{
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
    var desciption: String?
    var tags: String?
    
    /**
     get all or certain number of tags of a certain photo
     - Parameters : maxLength : the maximum number of tags to be retruned
     - Returns: an array of string that include the photo tags the maximum length of maxLength or tags array length
     */
    func getTags(_ maxLength: Int? = nil)-> [String]{
        var allTags = tags?.components(separatedBy: " ").filter({ $0 != ""}) ?? [] .sorted { lhs, rhs in
            return lhs > rhs
        }
        guard let length = maxLength else {
            return allTags
        }
        return allTags.count > length ? Array(allTags[0...length]) : allTags
    }
}
