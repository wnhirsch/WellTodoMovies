//
//  Button.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 21/04/21.
//

import UIKit

class Button: UIButton {
    
    enum Style {
        case primary
        case secondary
        
        var titleColor: UIColor {
            switch self {
            case .primary:
                return .white
            case .secondary:
                return .accent
            }
        }
        
        var tintColor: UIColor {
            switch self {
            case .primary:
                return .white
            case .secondary:
                return .accent
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .primary:
                return .accent
            case .secondary:
                return .black
            }
        }
    }
    
    var style: Style = .primary {
        didSet {
            setupByStyle()
        }
    }

    var title: String? {
        get { title(for: .normal) }
        set {
            UIView.performWithoutAnimation {
                setTitle(newValue, for: .normal)
                layoutIfNeeded()
            }
        }
    }

    var image: UIImage? {
        get { image(for: .normal) }
        set {
            UIView.performWithoutAnimation {
                setImage(newValue?.withRenderingMode(.alwaysTemplate), for: .normal)
                layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
}

extension Button {

    private func setup() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.accent.cgColor
        layer.cornerRadius = 8
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
        setupByStyle()
    }
    
    private func setupByStyle() {
        setTitleColor(style.titleColor, for: .normal)
        tintColor = style.tintColor
        layer.backgroundColor = style.backgroundColor.cgColor
    }
}
