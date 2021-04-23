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

class MovieDetailsController<ViewModel: MovieDetailsProtocol>: UIViewController {
    
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
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        bind()
        viewModel.fetchMovie()
    }
}

extension MovieDetailsController {

    private func bind() {
        contentView.bindIn(viewModel: viewModel)
        
        viewModel.onTapSimilarMovie = { [weak self] movie in
            self?.delegate?.goToSimilarMovie(movie: movie)
        }
    }
}
