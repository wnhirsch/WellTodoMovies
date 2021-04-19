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
        window.rootViewController = getFirstCoordinator()
        window.makeKeyAndVisible()
    }

    private func getFirstCoordinator() -> UIViewController {
        let movieCoordinator = MovieCoordinator()
        childCoordinator = movieCoordinator
        return movieCoordinator.containerViewController
    }
}
