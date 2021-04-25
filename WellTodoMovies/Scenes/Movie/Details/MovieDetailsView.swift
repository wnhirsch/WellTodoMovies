//
//  MovieDetailsView.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import UIKit

protocol MovieDetailsViewModelProtocol {
    var headerViewModel: MovieDetailsHeaderViewModelProtocol { get }
    var isLoadingSimilarMovies: Bool { get }
    
    var onChangeMovieDetails: ((MovieDetailsHeaderViewModelProtocol) -> Void)? { get set }
    var onSetSimilarMovies: ((SimilarMovieSection) -> Void)? { get set }
    var onAppendSimilarMovies: ((SimilarMovieSection) -> Void)? { get set }
    
    func fetchMoreSimilarMovies()
}

class MovieDetailsView: UIView {

    private let tableDataSource = TableViewDataSource()
    private var viewModel: MovieDetailsProtocol?

    // MARK: - UI Components
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var statusBarBackgroundView: UIView!
    
    // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    // MARK: - Bind
    func bindIn(viewModel: MovieDetailsProtocol) {
        self.viewModel = viewModel
        
        self.viewModel?.onChangeMovieDetails = { [weak self] headerViewModel in
            self?.setupTableHeaderView(viewModel: headerViewModel)
        }
        self.viewModel?.onSetSimilarMovies = { [weak self] section in
            self?.tableDataSource.sections = [section]
        }
        self.viewModel?.onAppendSimilarMovies = { [weak self] section in
            self?.tableDataSource.sections.append(section)
        }
        
        setupTableHeaderView(viewModel: viewModel.headerViewModel)
    }
    
    // MARK: - Utils
    func setupTableHeaderView(viewModel: MovieDetailsHeaderViewModelProtocol) {
        let headerView = MovieDetailsHeaderView.loadNib()
        headerView.bindIn(viewModel: viewModel)
        tableView.tableHeaderView = headerView
    }
}

extension MovieDetailsView {

    private func setup() {
        backgroundColor = .black
        setupTableView()
        setupStatusBarBackgroundView()
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .init(top: 0, left: 92, bottom: 0, right: 0)
        tableView.showsVerticalScrollIndicator = true
        tableView.insetsContentViewsToSafeArea = false
        tableView.contentInsetAdjustmentBehavior = .never
        
        let footerView = MovieDetailsFooterView.loadNib()
        footerView.bindIn(viewModel: MovieDetailsFooterViewModel())
        tableView.tableFooterView = footerView
        
        tableDataSource.tableView = tableView
        tableDataSource.scrollDelegate = self
    }
    
    private func setupStatusBarBackgroundView() {
        let gradient = CAGradientLayer()
        gradient.frame = statusBarBackgroundView.bounds
        gradient.colors = [UIColor.black.withAlphaComponent(0.4).cgColor,
                           UIColor.black.withAlphaComponent(0.2).cgColor,
                           UIColor.clear.cgColor]
        gradient.locations = [0, 0.6, 1]
        statusBarBackgroundView.layer.insertSublayer(gradient, at: 0)
        statusBarBackgroundView.backgroundColor = .clear
    }
}

extension MovieDetailsView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !(viewModel?.isLoadingSimilarMovies ?? true) &&
            scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            viewModel?.fetchMoreSimilarMovies()
        }
        let headerView = tableView.tableHeaderView as! MovieDetailsHeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
    }
}
