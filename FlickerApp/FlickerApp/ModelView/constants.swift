//
//  constants.swift
//  FlickerApp
//
//  Created by Soha Ahmed on 12/12/2023.
//

open class Constatnts{
    
   static let APIKey = "f46b7b3920dc5855bdfdbeacd14b3ebd"
    
   public static let USER_ID = "38945681@N07"
    
   public static let FLICKER_GET_PHOTOS = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(APIKey)&safe_search=safe"
    
    public static let EXTRAS = "privacy_filter=1&content_type=1&extras=url_l%2C+description%2C+tags&per_page=20"
    
    public static let FORMAT = "format=json&nojsoncallback=1"
    
    public static let FLICKER_GET_USER = "https://www.flickr.com/services/rest/?method=flickr.urls.lookupUser&api_key=\(APIKey)"
    
    public static let PROFILE_PHOTO = "https://farm9.staticflickr.com/8573/buddyicons/%@_l.jpg"
}