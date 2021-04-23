//
//  Images.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 21/04/21.
//

import UIKit

extension UIImage {
    
    static var back: UIImage {
        return UIImage(named: "Back") ?? UIImage()
    }
    
    static var circle: UIImage {
        return UIImage(systemName: "circle") ?? UIImage()
    }
    
    static var heart: UIImage {
        return UIImage(systemName: "heart") ?? UIImage()
    }
    
    static var heartFill: UIImage {
        return UIImage(systemName: "heart.fill") ?? UIImage()
    }
    
    static var posterPlaceholder: UIImage {
        return UIImage(named: "PosterPlaceholder") ?? UIImage()
    }
    
}
