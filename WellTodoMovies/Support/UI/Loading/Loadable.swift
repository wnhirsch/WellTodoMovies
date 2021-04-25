//
//  Loadable.swift
//  Muvver
//
//  Created by Wellington Nascente Hirsch on 25/04/21.
//

import UIKit

protocol Loadable {
    func showLoading(message: String?, on subview: UIView?)
    func hideLoading()
}

extension Loadable where Self: UIViewController {

    private func findLoadingView() -> LoadingView? {
        return view.subviews.compactMap { $0 as? LoadingView }.first
    }

    private func addLoadingView(subview: UIView? = nil) -> LoadingView {
        let loadingView = LoadingView.loadNib()
        loadingView.startAnimating()
        loadingView.alpha = 0

        view.addSubview(loadingView)
        
        if let view = subview ?? view {
            loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loadingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            loadingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        }

        return loadingView
    }

    // MARK: - Public
    func showLoading(message: String? = nil, on subview: UIView? = nil) {
        view.endEditing(true)
        
        if let loadingView = findLoadingView() {
            loadingView.message = message
            view.bringSubviewToFront(loadingView)
            return
        }

        let loadingView = addLoadingView(subview: subview)
        
        loadingView.message = message

        loadingView.alpha = 1
    }

    func hideLoading() {
        guard let loadingView = findLoadingView() else {
            return
        }

        UIView.animate(withDuration: 0.25, animations: {
            loadingView.alpha = 0
        }, completion: { _ in
            loadingView.stopAnimating()
            loadingView.removeFromSuperview()
        })
    }
    
}
