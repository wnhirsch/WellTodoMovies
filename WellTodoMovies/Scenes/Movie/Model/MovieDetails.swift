//
//  MovieDetails.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import Foundation

struct MovieDetails: Decodable {
    var id: Int
    var adult: Bool
    var backdropPath: String?
    var belongsToCollection: Collection?
    var budget: Int
    var genres: [GenresModel.Genre]
    var homepage: String?
    var imdbId: String?
    var originalLanguage: String
    var originalTitle: String
    var overview: String?
    var popularity: Double
    var posterPath: String?
    var productionCompanies: [Movie.Company]
    var productionCountries: [Movie.Country]
    var releaseDate: String
    var revenue: Int
    var runtime: Int
    var spokenLanguages: [Movie.Language]
    var status: Movie.Status
    var tagline: String?
    var title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int
}

extension MovieDetails {
    
    func toMovie() -> Movie {
        return Movie(posterPath: self.posterPath,
                     adult: self.adult,
                     overview: self.overview,
                     releaseDate: self.releaseDate,
                     genreIds: self.genres.map({ $0.id }),
                     id: self.id,
                     originalTitle: self.originalTitle,
                     originalLanguage: self.originalLanguage,
                     title: self.title,
                     backdropPath: self.backdropPath,
                     popularity: self.popularity,
                     video: self.video,
                     voteAverage: self.voteAverage,
                     voteCount: self.voteCount)
    }
}




