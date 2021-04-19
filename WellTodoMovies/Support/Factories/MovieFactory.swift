//
//  MovieFactory.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import UIKit

enum MovieFactory {

    static func movie(delegate: MovieDetailsControllerDelegate?) -> UIViewController {
        let useCase = GetSimilarMoviesUseCase(api: MovieRoutes())
        let viewModel = MovieDetailsViewModel(getSimilarMoviesUseCase: useCase)
        return MovieDetailsController(viewModel: viewModel, delegate: delegate)
    }
}
