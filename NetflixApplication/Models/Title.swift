//
//  Movie.swift
//  NetflixApplication
//
//  Created by pritam on 2024-01-12.
//

import Foundation


struct TitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_Type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
    let title: String?
    
}


/*
 adult = 0;
 "backdrop_path" = "/qgFrFXtiGfWN1zkk4sPd0nwFaBF.jpg";
 "genre_ids" =             (
     28,
     35,
     10749
 );
 id = 848187;
 "media_type" = movie;
 "original_language" = en;
 "original_title" = "Role Play";
 overview = "Emma has a wonderful husband and two kids in the suburbs of New Jersey \U2013 she also has a secret life as an assassin for hire \U2013 a secret that her husband David discovers when the couple decide to spice up their marriage with a little role play.";
 popularity = "26.68";
 "poster_path" = "/7MhXiTmTl16LwXNPbWCmqxj7UxH.jpg";
 "release_date" = "2023-12-14";
 title = "Role Play";
 video = 0;
 "vote_average" = "6.2";
 "vote_count" = 8;
 */
