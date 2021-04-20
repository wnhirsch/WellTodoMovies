//
//  Movie.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import Foundation

struct Movie: Decodable {
    var id: Int
    var adult: Bool
    var backdropPath: String?
    var genreIds: [Int]
    var originalLanguage: String
    var originalTitle: String
    var overview: String?
    var popularity: Double
    var posterPath: String?
    var releaseDate: String
    var tagline: String?
    var video: Bool
    var voteAverage: Double
    var voteCount: Int
}

extension Movie {
    
    struct Company: Decodable {
        var id: Int
        var name: String
        var logoPath: String?
        var originCountry: String
    }
    
    struct Country: Decodable {
        var iso31661: String
        var name: String
    }
    
    struct Language: Decodable {
        var iso6391: String
        var name: String
    }
    
    enum Status: String, CaseIterable, Codable {
        case rumored = "Rumored"
        case planned = "Planned"
        case inProduction = "In Production"
        case postProduction = "Post Production"
        case released = "Released"
        case canceled = "Canceled"
    }
}
