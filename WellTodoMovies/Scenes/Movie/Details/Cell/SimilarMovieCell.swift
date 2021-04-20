//
//  SimilarMovieCell.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 19/04/21.
//

import UIKit

protocol SimilarMovieCellProtocol: TableViewModelProtocol {
    var posterURL: URL { get }
    var title: String { get }
    var year: String? { get }
    var genres: String { get }
    
    var onClick: (() -> Void)? { get set }
}

class SimilarMovieCell: UITableViewCell {

    private var viewModel: SimilarMovieCellProtocol?

    // MARK: - UI Components
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    
    // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    // MARK: - Bind
    func bindIn(viewModel: SimilarMovieCellProtocol) {
        self.viewModel = viewModel

        posterImageView.imageBy(url: viewModel.posterURL, placeholder: UIImage(named: "PosterPlaceholder"))
        titleLabel.text = viewModel.title
        yearLabel.text = viewModel.year
        genresLabel.text = viewModel.genres
    }
}

extension SimilarMovieCell {

    private func setup() {
        backgroundColor = .black
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.darkGray
        selectedBackgroundView = backgroundView
        
        setupPosterImageView()
        setupTitleLabel()
        setupYearLabel()
        setupGenresLabel()
    }

    private func setupPosterImageView() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.image = UIImage(named: "PosterPlaceholder")
    }

    private func setupTitleLabel() {
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont(name: "system", size: 20)
        titleLabel.textColor = .white
    }
    
    private func setupYearLabel() {
        yearLabel.numberOfLines = 1
        yearLabel.font = UIFont(name: "system", size: 16)
        yearLabel.textColor = .white
    }
    
    private func setupGenresLabel() {
        genresLabel.numberOfLines = 1
        genresLabel.font = UIFont(name: "system", size: 16)
        genresLabel.textColor = .lightGray
    }
}
