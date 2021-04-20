//
//  UIImageView+URL.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 20/04/21.
//

import Kingfisher

extension UIImageView {

    func imageBy(url: URL?, placeholder: UIImage? = nil) {
        self.kf.setImage(with: url, placeholder: placeholder)
    }
}
