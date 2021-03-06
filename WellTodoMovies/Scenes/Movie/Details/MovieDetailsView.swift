//
//  MovieDetailsView.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import UIKit

protocol MovieDetailsViewModelProtocol {
    var headerViewModel: MovieDetailsHeaderViewModelProtocol { get }
    var footerViewModel: MovieDetailsFooterViewModelProtocol { get }
    var isLoadingSimilarMovies: Bool { get }
    
    var onStartGetSimilarMovies: (() -> Void)? { get set }
    var onSetSimilarMovies: ((SimilarMovieSection) -> Void)? { get set }
    var onAppendSimilarMovies: ((SimilarMovieSection) -> Void)? { get set }
    var onEndGetSimilarMovies: (() -> Void)? { get set }
    
    var onChangeMovieHeader: ((MovieDetailsHeaderViewModelProtocol) -> Void)? { get set }
    var onChangeMovieFooter: ((MovieDetailsFooterViewModelProtocol) -> Void)? { get set }
    
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
        
        self.viewModel?.onChangeMovieHeader = { [weak self] headerViewModel in
            self?.setupTableHeaderView(viewModel: headerViewModel)
        }
        self.viewModel?.onChangeMovieFooter = { [weak self] footerViewModel in
            self?.setupTableFooterView(viewModel: footerViewModel)
        }
        
        self.viewModel?.onStartGetSimilarMovies = { [weak self] in
            self?.tableDataSource.sections.append(LoadingSection())
        }
        self.viewModel?.onSetSimilarMovies = { [weak self] section in
            self?.tableDataSource.sections = [section]
        }
        self.viewModel?.onAppendSimilarMovies = { [weak self] section in
            self?.tableDataSource.sections.removeLast()
            self?.tableDataSource.sections.append(section)
        }
        self.viewModel?.onEndGetSimilarMovies = { [weak self] in
            self?.tableDataSource.sections.removeLast()
        }
        
        self.tableDataSource.onUpdateHeaderView = { [weak self] in
            self?.setupTableHeaderView(viewModel: viewModel.headerViewModel)
        }
        self.tableDataSource.onUpdateFooterView = { [weak self] in
            self?.setupTableFooterView(viewModel: viewModel.footerViewModel)
        }
        
        setupTableHeaderView(viewModel: viewModel.headerViewModel)
        setupTableFooterView(viewModel: viewModel.footerViewModel)
    }
    
    // MARK: - Utils
    func setupTableHeaderView(viewModel: MovieDetailsHeaderViewModelProtocol) {
        let headerView = MovieDetailsHeaderView.loadNib()
        headerView.bindIn(viewModel: viewModel)
        tableView.tableHeaderView = headerView
    }
    
    func setupTableFooterView(viewModel: MovieDetailsFooterViewModelProtocol) {
        let footerView = MovieDetailsFooterView.loadNib()
        footerView.bindIn(viewModel: viewModel)
        tableView.tableFooterView = footerView
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
        tableDataSource.tableView = tableView
        tableDataSource.scrollDelegate = self
    }
    
    private func setupStatusBarBackgroundView() {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width,
                                height: statusBarBackgroundView.frame.height)
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
