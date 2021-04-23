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
        return navigationController
    }
    
    private let navigationController = UINavigationController()
    
    func start() {
        let movieVc = MovieFactory.movie(movieID: 550, delegate: self)
        navigationController.pushViewController(movieVc, animated: false)
    }
}

extension MovieCoordinator: MovieDetailsControllerDelegate {

    func goToSimilarMovie(movie: Movie) {
        let movieVc = MovieFactory.movie(movie: movie, delegate: self)
        navigationController.pushViewController(movieVc, animated: true)
    }
    
}
