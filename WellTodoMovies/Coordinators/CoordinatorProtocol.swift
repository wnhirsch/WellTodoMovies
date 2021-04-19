//
//  CoordinatorProtocol.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import UIKit

// MARK: - CoordinatorProtocol
protocol CoordinatorProtocol: ChildCoordinatorDelegate {
    var childDelegate: ChildCoordinatorDelegate? { get set }
    var childCoordinator: CoordinatorProtocol? { get set }
    var containerViewController: UIViewController { get }
}

// MARK: - ChildCoordinatorDelegate
protocol ChildCoordinatorDelegate: AnyObject {
    func didStartDismiss()
    func finishedFlow()
}

extension ChildCoordinatorDelegate {
    func didStartDismiss() { }
}

extension ChildCoordinatorDelegate where Self: CoordinatorProtocol {

    func finishedFlow() {
        childCoordinator = nil
    }
}
