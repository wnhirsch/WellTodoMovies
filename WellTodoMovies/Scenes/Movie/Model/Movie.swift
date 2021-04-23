//
//  Movie.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import Foundation

struct Movie: Decodable {
    var posterPath: String?
    var adult: Bool
    var overview: String?
    var releaseDate: String
    var genreIds: [Int]
    var id: Int
    var originalTitle: String
    var originalLanguage: String
    var title: String
    var backdropPath: String?
    var popularity: Double
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
