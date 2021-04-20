//
//  UITableView+Reusable.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 19/04/21.
//

import UIKit

extension UITableView {

    func registerNib<T: UITableViewCell>(_ type: T.Type) {
        let nib = UINib(nibName: type.reuseIdentifier, bundle: Bundle(for: type))
        self.register(nib, forCellReuseIdentifier: type.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        let dequeueCell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath)

        guard let cell = dequeueCell as? T else {
            fatalError("Could not dequeue cell with identifier: \(cellType.reuseIdentifier)")
        }
        
        return cell
    }
}
