//
//  MovieDetailsHeaderView.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 22/04/21.
//

import UIKit

protocol MovieDetailsHeaderViewModelProtocol {
    var posterURL: URL { get }
    var title: String { get }
    var isLiked: Bool { get }
    var likes: String { get }
    var popularity: String { get }
    
    var onLikeChange: ((Bool) -> Void)? { get set }
    
    func likeButtonClick()
}

class MovieDetailsHeaderView: UIView {
    
    private var viewModel: MovieDetailsHeaderViewModelProtocol?

    // MARK: - UI Components
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var likeButtonImageView: UIImageView!
    @IBOutlet private weak var likesImageView: UIImageView!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var popularityImageView: UIImageView!
    @IBOutlet private weak var popularityLabel: UILabel!
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    // MARK: - Bind
    func bindIn(viewModel: MovieDetailsHeaderViewModelProtocol) {
        self.viewModel = viewModel
        
        posterImageView.imageBy(url: viewModel.posterURL, placeholder: UIImage.posterPlaceholder)
        titleLabel.text = viewModel.title
        likesLabel.text = viewModel.likes
        popularityLabel.text = viewModel.popularity
        
        self.viewModel?.onLikeChange = { [weak self] isLiked in
            self?.setLikeButtonStatus(isSelected: isLiked, animated: true)
        }
        
        setLikeButtonStatus(isSelected: viewModel.isLiked)
    }
    
    // MARK: - Actions
    @objc func didTapLikeButton() {
        viewModel?.likeButtonClick()
    }
    
    // MARK: - Utils
    func setLikeButtonStatus(isSelected: Bool, animated: Bool = false) {
        if isSelected {
            likeButtonImageView.image = UIImage.heartFill
        } else {
            likeButtonImageView.image = UIImage.heart
        }
    }
}

extension MovieDetailsHeaderView {

    private func setup() {
        backgroundColor = .black
        setupPosterImageView()
        setupGradientView()
        setupTitleLabel()
        setupLikeButton()
        setupLikesImageView()
        setupLikesLabel()
        setupPopularityImageView()
        setupPopularityLabel()
    }
    
    private func setupPosterImageView() {
        posterImageView.contentMode = .scaleAspectFill
    }
    
    private func setupGradientView() {
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.clear.cgColor,
                           UIColor.black.withAlphaComponent(0.3).cgColor,
                           UIColor.black.withAlphaComponent(0.8).cgColor,
                           UIColor.black.cgColor]
        gradient.locations = [0, 0.2, 0.9, 1]
        gradientView.layer.insertSublayer(gradient, at: 0)
        gradientView.backgroundColor = .clear
    }
    
    private func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textColor = .white
    }
    
    private func setupLikeButton() {
        likeButtonImageView.tintColor = .white
        likeButtonImageView.image = UIImage.heart
        
        let tapLikeButton = UITapGestureRecognizer(target: self, action: #selector(didTapLikeButton))
        likeButtonImageView.isUserInteractionEnabled = true
        likeButtonImageView.addGestureRecognizer(tapLikeButton)
    }
    
    private func setupLikesImageView() {
        likesImageView.tintColor = .white
        likesImageView.image = UIImage.heartFill
    }
    
    private func setupLikesLabel() {
        likesLabel.numberOfLines = 1
        likesLabel.font = UIFont.systemFont(ofSize: 16)
        likesLabel.textColor = .white
    }
    
    private func setupPopularityImageView() {
        popularityImageView.tintColor = .white
        popularityImageView.image = UIImage.circle
    }
    
    private func setupPopularityLabel() {
        popularityLabel.numberOfLines = 1
        popularityLabel.font = UIFont.systemFont(ofSize: 16)
        popularityLabel.textColor = .white
    }
}
