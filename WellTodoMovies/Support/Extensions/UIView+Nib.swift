//
//  UIView+Nib.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import UIKit

extension UIView {

    static func loadNib(name: String? = nil) -> Self {
        let nibName = name ?? String(describing: self)
        
        guard let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as? Self else {
            fatalError("could not load \(nibName) as xib")
        }

        return view
    }
}
