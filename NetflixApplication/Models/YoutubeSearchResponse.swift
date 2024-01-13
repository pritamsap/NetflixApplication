//
//  YoutubeSearchResponse.swift
//  NetflixApplication
//
//  Created by pritam on 2024-01-13.
//

import Foundation


struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String?
}



/*
 items =     (
             {
         etag = 1sQsWeAuebquCrvgqRFWKIYbDoE;
         id =             {
             kind = "youtube#video";
             videoId = 5AUQ4ASH0wE;
         };n
         kind = "youtube#searchResult";
     },
 */
