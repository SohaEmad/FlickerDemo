# FlickrDemo

![](https://img.shields.io/badge/Swift:-5.3_5.4_5.5-ff5900.svg)
![](https://img.shields.io/badge/Platform:-_iOS-ff5900.svg)
![](https://img.shields.io/badge/chip_support:-M1-ff5900.svg)

## SwiftUI implementation of a Flickr photo browser.

API Resource [Flickr api](https://www.flickr.com/services/api/flickr.photos.search.html)


### APP Preview/Screens:

1- splash screen 

<img src="https://github.com/SohaEmad/FlickerDemo/blob/main/photos/splash_screen.gif" width="200">

2- home view 
<img src="https://github.com/SohaEmad/FlickerDemo/blob/main/photos/main_view.jpg" width="200">

2- search view 

<img src="https://github.com/SohaEmad/FlickerDemo/blob/main/photos/search_view.gif" width="200">

3- user view

<img src="https://github.com/SohaEmad/FlickerDemo/blob/main/photos/user_view.gif" width="200">

4- user input view 

<img src="https://github.com/SohaEmad/FlickerDemo/blob/main/photos/user_search.jpg" width="200">

5- detalis view 

<img src="https://github.com/SohaEmad/FlickerDemo/blob/main/photos/details_screen.gif" width="200">

6- location based view 
<img src="https://github.com/SohaEmad/FlickerDemo/blob/main/photos/location_view.jpg" width="200">

(you will need to allow location access to enable the above screen)

To search: enter a category, then free text deliminated by a comma e.g.

Rocket, spacex  <- this will search for tags of Rocket with text spacex.

Guitar, Amplifiers, fender <- this will search for 2 tags Guitar and Amplifier with text fender.

#Run
1. Open up xcode (>=11) 
2. navigate to the project FlickrPics
3. choose your device or simulator
4. hit run

##Decision Explination: 

1. The initial attempt to search for a user by name using `findByUsername` yielded inconsistent results, as evidenced in the provided code. Subsequently, I opted for the more efficient and consistent `lookupUser` method. The code snippet below illustrates this transition:

``` 
https://www.flickr.com/services/api/render?method=flickr.people.findByUsername&api_key=f46b7b3920dc5855bdfdbeacd14b3ebd&username=Tony&format=json&nojsoncallback=?

Optional("<style>body{color:#black;} span.q{color:#FF0084;} span.ns{color:#0259C4; font-weight:bold;} span.n{color:#666666;} span.at{font-weight:bold;}</style><pre>{\n    \"user\": {\n        \"id\": \"22475797@N02\",\n        \"nsid\": \"22475797@N02\",\n        \"username\": {\n            \"_content\": \"Tony\"\n        }\n    },\n    \"stat\": \"ok\"\n}</pre>")
dataCorrupted(Swift.DecodingError.Context(codingPath: [], debugDescription: "The given data was not valid JSON.", underlyingError: Optional(Error Domain=NSCocoaErrorDomain Code=3840 "Unexpected character '<' around line 1, column 1." UserInfo={NSDebugDescription=Unexpected character '<' around line 1, column 1., NSJSONSerializationErrorIndex=0})))


https://www.flickr.com/services/api/render?method=flickr.people.findByUsername&api_key=f46b7b3920dc5855bdfdbeacd14b3ebd&username=Tony&format=json&nojsoncallback=?

Optional("{\"user\":{\"id\":\"22475797@N02\",\"nsid\":\"22475797@N02\",\"username\":{\"_content\":\"Tony\"}},\"stat\":\"ok\"}")
Optional("https://farm9.staticflickr.com/8573/buddyicons/22475797@N02_l.jpg")
```

2. I implemented two screens—one with a home screen lacking a search option and another incorporating a search feature. This design choice was inspired by the interface of popular apps such as Pinterest.

3. To enhance the user experience, I limited the display of tags for each photo on the main screen to a maximum of three. This decision was made to address the issue of cluttered views caused by an excessive number of tags associated with some photos.

4. The project employs the MVVM architecture due to its simplicity and suitability for the given requirements.

5. The inclusion of the location provider is an additional modification aimed at leveraging the location feature in the GET API.

6. Future work, time permitting, would revolve around thorough testing and the implementation of robust error handling mechanisms.