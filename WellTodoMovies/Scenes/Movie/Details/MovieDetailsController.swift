//
//  MovieDetailsController.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import UIKit

protocol MovieDetailsControllerDelegate: AnyObject {
    func goToSimilarMovie(movie: Movie)
}

class MovieDetailsController<ViewModel: MovieDetailsProtocol>: UIViewController, Loadable {
    
    private var viewModel: ViewModel
    private let contentView: MovieDetailsView
    private weak var delegate: MovieDetailsControllerDelegate?

    // MARK: - Init
    init(viewModel: ViewModel, delegate: MovieDetailsControllerDelegate?) {
        self.viewModel = viewModel
        self.contentView = MovieDetailsView.loadNib()
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Controller life cycle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Transparent Navigation Bar
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // Back Button
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(image: .back, style: .plain, target: nil, action: nil)
        
        bind()
        viewModel.fetchMovie()
    }
}

extension MovieDetailsController {

    private func bind() {
        contentView.bindIn(viewModel: viewModel)
        
        viewModel.onStartGetMovieDetails = { [weak self] in
            self?.showLoading()
        }
        
        viewModel.onSuccessGetMovieDetails = { [weak self] in
            self?.hideLoading()
        }
        
        viewModel.onFailureGetMovieDetails = { [weak self] error in
            self?.showErrorAlert(message: error)
        }
        
        viewModel.onFailureGetSimilarMovies = { [weak self] error in
            self?.showErrorAlert(message: error)
        }
        
        viewModel.onTapSimilarMovie = { [weak self] movie in
            self?.delegate?.goToSimilarMovie(movie: movie)
        }
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "error.title".localized(context: .default),
                                      message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "ok".localized(context: .default), style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }
}
