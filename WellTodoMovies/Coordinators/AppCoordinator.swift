//
//  AppCoordinator.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import UIKit

class AppCoordinator {

    private let window: UIWindow
    private(set) var childCoordinator: CoordinatorProtocol?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        Genres.shared.updateData(completion: { [weak self] _ in
            self?.setFirstCoordinator()
        })
    }
    
    private func setFirstCoordinator() {
        let movieCoordinator = MovieCoordinator()
        movieCoordinator.start()
        childCoordinator = movieCoordinator
        window.rootViewController = movieCoordinator.containerViewController
        window.makeKeyAndVisible()
    }
}
