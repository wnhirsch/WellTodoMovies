//
//  MovieGenres.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 20/04/21.
//

import Foundation

protocol GenresProtocol {
    typealias Success = (() -> Void)
    typealias Failure = (() -> Void)
    
    func getMovieGenre(id: Int) -> String?
    func updateData(completion: ((Bool) -> Void)?)
}

class Genres {
    static let shared: GenresProtocol = Genres()
    
    private var forMovies: [Int: String] = [:]
    private let forMoviesUseCase: GetMovieGenreListUseCaseProtocol = GetMovieGenreListUseCase(api: GenreRoutes())
}

extension Genres: GenresProtocol {
    
    func getMovieGenre(id: Int) -> String? {
        return forMovies[id]
    }
    
    func updateData(completion: ((Bool) -> Void)? = nil) {
        self.forMoviesUseCase.execute(success: { [weak self] result in
            self?.forMovies.removeAll()
            result.genres.forEach({ self?.forMovies[$0.id] = $0.name })
            print(self?.forMovies)
            completion?(true)
        }, failure: { error in
            print(error.statusMessage)
            completion?(false)
        })
    }
}
