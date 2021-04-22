//
//  MovieDetailsFooterView.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 21/04/21.
//

import UIKit

protocol MovieDetailsFooterViewModelProtocol {
    var isLiked: Bool { get }
    var isOnMyLists: Bool { get }
    
    var onLikeChange: ((Bool) -> Void)? { get set }
    var onMyListsChange: ((Bool) -> Void)? { get set }
    
    func likeButtonClick()
    func myListButtonClick()
}

class MovieDetailsFooterView: UIView {
    
    private var viewModel: MovieDetailsFooterViewModelProtocol?

    // MARK: - UI Components
    @IBOutlet private weak var likeButton: Button!
    @IBOutlet private weak var myListButton: Button!
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    // MARK: - Bind
    func bindIn(viewModel: MovieDetailsFooterViewModelProtocol) {
        self.viewModel = viewModel
        
        self.viewModel?.onLikeChange = { [weak self] isLiked in
            self?.setLikeButtonStatus(isSelected: isLiked)
        }
        self.viewModel?.onMyListsChange = { [weak self] isOnMyLists in
            self?.setMyListsButtonStatus(isSelected: isOnMyLists)
        }
        
        setLikeButtonStatus(isSelected: viewModel.isLiked)
        setMyListsButtonStatus(isSelected: viewModel.isOnMyLists)
    }
    
    // MARK: - Actions
    @objc func didTapLikeButton() {
        viewModel?.likeButtonClick()
    }
    
    @objc func didTapMyListButton() {
        viewModel?.myListButtonClick()
    }
    
    // MARK: - Utils
    func setLikeButtonStatus(isSelected: Bool) {
        if isSelected {
            likeButton.style = .primary
            likeButton.title = "liked".localized(context: .movieDetailsFooter)
            likeButton.image = UIImage.heartFill
        } else {
            likeButton.style = .secondary
            likeButton.title = "like".localized(context: .movieDetailsFooter)
            likeButton.image = UIImage.heart
        }
    }
    
    func setMyListsButtonStatus(isSelected: Bool) {
        if isSelected {
            myListButton.style = .primary
            myListButton.title = "myList.added".localized(context: .movieDetailsFooter)
        } else {
            myListButton.style = .secondary
            myListButton.title = "myList.add".localized(context: .movieDetailsFooter)
        }
    }
}

extension MovieDetailsFooterView {

    private func setup() {
        backgroundColor = .black
        setupLikeButton()
        setupMyListButton()
    }
    
    private func setupLikeButton() {
        likeButton.style = .secondary
        likeButton.title = "like".localized(context: .movieDetailsFooter)
        likeButton.image = UIImage.heart
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
    }
    
    private func setupMyListButton() {
        myListButton.style = .secondary
        myListButton.title = "myList.add".localized(context: .movieDetailsFooter)
        myListButton.addTarget(self, action: #selector(didTapMyListButton), for: .touchUpInside)
    }
}
