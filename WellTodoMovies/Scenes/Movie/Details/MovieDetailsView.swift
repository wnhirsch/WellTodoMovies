//
//  MovieDetailsView.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import UIKit

protocol MovieDetailsViewModelProtocol {
//    var movieHeaderViewModel: MovieHeaderViewModelProtocol { get }
    var cachedSimilarMovies: [Movie] { get }
    
    var onChangeSimilarMovies: (() -> Void)? { get set }
    
    func clickMovie()
}

class MovieDetailsView: UIView {

    private var viewModel: MovieDetailsProtocol?

    // MARK: - UI Components
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    // MARK: - Bind
    func bindIn(viewModel: MovieDetailsProtocol) {
        self.viewModel = viewModel
        
        self.viewModel?.onChangeSimilarMovies = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension MovieDetailsView {

    private func setup() {
        backgroundColor = .black
        setupTableView()
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SimilarMovieCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MovieDetailsView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cachedSimilarMovies.count ?? Int.zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SimilarMovieCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = viewModel?.cachedSimilarMovies[indexPath.row].originalTitle
        
        return cell
    }
    
}
