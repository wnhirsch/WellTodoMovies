//
//  LoadingCell.swift
//  Muvver
//
//  Created by Wellington Nascente Hirsch on 25/04/21.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - View life cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func animate() {
        activityIndicator.startAnimating()
    }
}

extension LoadingCell {

    private func setup() {
        backgroundColor = .black
        setupActivityIndicator()
    }

    private func setupActivityIndicator() {
        activityIndicator.color = .white
        activityIndicator.style = .medium
    }
}
