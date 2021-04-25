//
//  LoadingView.swift
//  Muvver
//
//  Created by Wellington Nascente Hirsch on 25/04/21.
//

import UIKit

class LoadingView: UIView {

    var message: String? {
        get { messageLabel.text }
        set { messageLabel.text = newValue }
    }

    // MARK: - UI Components
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    // MARK: - Public
    func startAnimating() {
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}

extension LoadingView {

    private func setup() {
        backgroundColor = .black
        setupMessageLabel()
        setupActivityIndicator()
    }

    private func setupMessageLabel() {
        messageLabel.text = nil
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 16)
    }

    private func setupActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = false
    }
}
