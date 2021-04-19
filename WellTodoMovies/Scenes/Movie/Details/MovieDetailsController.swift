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
        bind()
        viewModel.fetchSimilarMovies()
    }
}

extension MovieDetailsController {

    private func bind() {
        contentView.bindIn(viewModel: viewModel)
        
        viewModel.onStartGetSimilarMovies = { [weak self] in
            print("TODO: show loading")
        }
        
        viewModel.onEmptyGetSimilarMovies = { [weak self] in
            print("TODO: alert is empty")
        }

        viewModel.onSuccessGetSimilarMovies = { [weak self] in
            print("TODO: hide loading/alert")
        }

        viewModel.onFailureGetSimilarMovies = { [weak self] error in
            print("TODO: alert error")
            print(error)
        }
    }
}
