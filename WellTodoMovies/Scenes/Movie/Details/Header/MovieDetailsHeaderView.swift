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
    
    var onUpdateLikeButton: ((Bool) -> Void)? { get set }
    
    func likeButtonClick()
}

class MovieDetailsHeaderView: UIView {
    
    private var viewModel: MovieDetailsHeaderViewModelProtocol?
    private var imageTopConstraint: NSLayoutConstraint = .init()

    // MARK: - UI Components
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var infoStackView: UIStackView!
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var likeButtonImageView: UIImageView!
    @IBOutlet private weak var aboutView: UIView!
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
        titleLabel.setTextWithDynamicHeight(text: viewModel.title)
        likesLabel.text = viewModel.likes
        popularityLabel.text = viewModel.popularity
        
        self.viewModel?.onUpdateLikeButton = { [weak self] isLiked in
            self?.setLikeButtonStatus(isSelected: isLiked, animated: true)
        }
        
        setLikeButtonStatus(isSelected: viewModel.isLiked)
        reloadConstrints()
    }
    
    // MARK: - Actions
    @objc func didTapLikeButton() {
        viewModel?.likeButtonClick()
    }
    
    // MARK: - Utils
    func setLikeButtonStatus(isSelected: Bool, animated: Bool = false) {
        if isSelected {
            likeButtonImageView.image = UIImage.heartFill
            if animated {
                let animatedImage = UIImageView.init(image: .heartFill)
                animatedImage.tintColor = .white
                animatedImage.frame = infoStackView.convert(likeButtonImageView.frame, from: titleView)
                animatedImage.layoutIfNeeded()
                infoStackView.addSubview(animatedImage)
                
                let scaleValue = likesImageView.frame.width / likeButtonImageView.frame.width
                let scaleTransform = CGAffineTransform(scaleX: scaleValue, y: scaleValue)
                
                let finalWidth = likesImageView.frame.width / 4.0 - 1.0
                let startPoint = CGPoint(x: animatedImage.frame.origin.x, y: animatedImage.frame.origin.y)
                let finalFrame = infoStackView.convert(likesImageView.frame, from: aboutView)
                let finalPoint = CGPoint(x: finalFrame.origin.x, y: finalFrame.origin.y)
                let translationTransform = CGAffineTransform(translationX: finalPoint.x - startPoint.x - finalWidth,
                                                             y: finalPoint.y - startPoint.y - finalWidth)
                
                UIView.animate(withDuration: 0.6, delay: 0.0,
                               options: [.curveEaseIn], animations: {
                    animatedImage.transform = scaleTransform.concatenating(translationTransform)
                }, completion: { finished in
                    animatedImage.removeFromSuperview()
                    UIView.animate(withDuration: 0.1, delay: 0.1, options: [.curveEaseOut], animations: {
                        self.likesImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    }, completion: { finished in
                        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseIn], animations: {
                            self.likesImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        }, completion: { finished in
                            self.likesImageView.transform = .identity
                        })
                    })
                })
            }
        } else {
            likeButtonImageView.image = UIImage.heart
        }
    }
    
    func reloadConstrints() {
        imageTopConstraint.constant = .zero
        frame = CGRect(x: 0, y: 0, width: frame.width,
                       height: UIScreen.main.bounds.height / 2 + infoStackView.frame.height)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= max(gradientView.frame.minY, 0.0) {
            imageTopConstraint.constant = -scrollView.contentOffset.y
        }
    }
}

extension MovieDetailsHeaderView {

    private func setup() {
        backgroundColor = .black
        clipsToBounds = false
        setupConstraints()
        
        setupPosterImageView()
        setupGradientView()
        setupTitleLabel()
        setupLikeButton()
        setupLikesImageView()
        setupLikesLabel()
        setupPopularityImageView()
        setupPopularityLabel()
    }
    
    private func setupConstraints() {
        frame = CGRect(x: 0, y: 0, width: frame.width,
                       height: UIScreen.main.bounds.height / 2 + infoStackView.frame.height)
        imageTopConstraint = topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: .zero)
        imageTopConstraint.isActive = true
    }
    
    private func setupPosterImageView() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.image = .posterPlaceholder
    }
    
    private func setupGradientView() {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width,
                                height: gradientView.frame.height)
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
        titleLabel.lineBreakMode = .byWordWrapping
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
