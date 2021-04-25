//
//  SimilarMovieCellViewModel.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 19/04/21.
//

import UIKit

struct SimilarMovieCellViewModel: SimilarMovieCellProtocol {
    
    private let movie: Movie
    
    var onClick: (() -> Void)?
    
    init(movie: Movie, onClick: ((Movie) -> Void)?) {
        self.movie = movie
        self.onClick = {
            onClick?(movie)
        }
    }
    
    var posterURL: URL {
        return APIHost.baseImageURL.appendingPathComponent(movie.posterPath ?? String())
    }
    var title: String {
        return movie.title
    }
    var year: String? {
        return movie.releaseDate
            .toDate(format: Date.rawDateFormat)?
            .toString(format: Date.yearFormat)
    }
    var genres: String {
        var genres: String = .init()
        var offset: Int = .zero
        for (index, genreId) in movie.genreIds.enumerated() {
            if let genre = Genres.shared.getMovieGenre(id: genreId) {
                if index - offset == 0 {
                    genres = genre
                } else {
                    genres.append(", \(genre)")
                }
            } else {
                offset += 1
            }
        }
        return genres
    }
}
