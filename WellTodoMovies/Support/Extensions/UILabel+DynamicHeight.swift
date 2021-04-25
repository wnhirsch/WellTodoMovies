//
//  UILabel+DynamicHeight.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 24/04/21.
//

import UIKit

extension UILabel {
    
    func setTextWithDynamicHeight(text: String?) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width,
                                          height: .greatestFiniteMagnitude))
        label.text = text
        label.font = font
        label.numberOfLines = 0
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        
        let dynamicHeight = label.frame.height
        label.removeFromSuperview()
        
        self.text = text
        self.frame = CGRect(x: frame.minX, y: frame.minY,
                            width: frame.width, height: dynamicHeight)
        
        print(dynamicHeight)
        print(self.frame)
    }
    
}
