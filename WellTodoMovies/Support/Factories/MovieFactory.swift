//
//  MovieFactory.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import UIKit

enum MovieFactory {
    
    static func movie(movieID: Int, delegate: MovieDetailsControllerDelegate?) -> UIViewController {
        let getMovieDetailsUseCase = GetMovieDetailsUseCase(api: MovieRoutes())
        let getSimilarMoviesUseCase = GetSimilarMoviesUseCase(api: MovieRoutes())
        let viewModel = MovieDetailsViewModel(movieID: movieID, getMovieDetailsUseCase: getMovieDetailsUseCase,
                                              getSimilarMoviesUseCase: getSimilarMoviesUseCase)
        return MovieDetailsController(viewModel: viewModel, delegate: delegate)
    }
    
    static func movie(movie: Movie, delegate: MovieDetailsControllerDelegate?) -> UIViewController {
        let getMovieDetailsUseCase = GetMovieDetailsUseCase(api: MovieRoutes())
        let getSimilarMoviesUseCase = GetSimilarMoviesUseCase(api: MovieRoutes())
        let viewModel = MovieDetailsViewModel(movie: movie, getMovieDetailsUseCase: getMovieDetailsUseCase,
                                              getSimilarMoviesUseCase: getSimilarMoviesUseCase)
        return MovieDetailsController(viewModel: viewModel, delegate: delegate)
    }
}
