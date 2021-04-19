//
//  MovieCoordinator.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import UIKit

class MovieCoordinator: CoordinatorProtocol {

    var childCoordinator: CoordinatorProtocol?
    weak var childDelegate: ChildCoordinatorDelegate?

    var containerViewController: UIViewController {
        return movieController
    }

    private lazy var movieController = MovieFactory.movie(delegate: self)
}

extension MovieCoordinator: MovieDetailsControllerDelegate {

    func goToSimilarMovie(movie: Movie) {
        
    }
    
}
