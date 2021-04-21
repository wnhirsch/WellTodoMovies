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
    
    func likeButtonClick()
    func myListButtonClick()
}

class MovieDetailsFooterView: UIView {
    
    private var viewModel: MovieDetailsFooterViewModelProtocol?

    // MARK: - UI Components
    @IBOutlet weak var contentView: UIView?
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var myListButton: UIButton!
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    // MARK: - Bind
    func bindIn(viewModel: MovieDetailsFooterViewModelProtocol) {
        self.viewModel = viewModel
        
        likeButton.isSelected = viewModel.isLiked
        myListButton.isSelected = viewModel.isOnMyLists
    }
    
    // MARK: - Actions
    @objc func didTapLikeButton() {
        likeButton.isSelected = !likeButton.isSelected
        likeButton.layer.backgroundColor = (likeButton.isSelected ?
            UIColor.accent.cgColor : UIColor.black.cgColor)
        likeButton.tintColor = (likeButton.isSelected ? UIColor.white : UIColor.accent)
        
        viewModel?.likeButtonClick()
    }
    
    @objc func didTapMyListButton() {
        myListButton.isSelected = !myListButton.isSelected
        myListButton.layer.backgroundColor = (myListButton.isSelected ?
            UIColor.accent.cgColor : UIColor.black.cgColor)
        myListButton.tintColor = (likeButton.isSelected ? UIColor.white : UIColor.accent)
        
        viewModel?.myListButtonClick()
    }
}

extension MovieDetailsFooterView {

    private func setup() {
        backgroundColor = .black
        setupLikeButton()
        setupMyListButton()
    }
    
    private func setupLikeButton() {
        likeButton.layer.cornerRadius = 8
        likeButton.layer.borderWidth = 1
        likeButton.layer.borderColor = UIColor.accent.cgColor
        likeButton.layer.backgroundColor = UIColor.black.cgColor
        likeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
        
        likeButton.setTitle("like".localized(context: .movieDetailsFooter), for: .normal)
        likeButton.setTitle("liked".localized(context: .movieDetailsFooter), for: .selected)
        
        likeButton.setTitleColor(UIColor.accent, for: .normal)
        likeButton.setTitleColor(UIColor.white, for: .selected)
        
        likeButton.setImage(UIImage.heart, for: .normal)
        likeButton.setImage(UIImage.heartFill, for: .selected)
        
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
    }
    
    private func setupMyListButton() {
        myListButton.layer.cornerRadius = 8
        myListButton.layer.borderWidth = 1
        myListButton.layer.borderColor = UIColor.accent.cgColor
        myListButton.layer.backgroundColor = UIColor.black.cgColor
        
        myListButton.setTitle("myList.add".localized(context: .movieDetailsFooter), for: .normal)
        myListButton.setTitle("myList.added".localized(context: .movieDetailsFooter), for: .selected)
        
        myListButton.setTitleColor(UIColor.accent, for: .normal)
        myListButton.setTitleColor(UIColor.white, for: .selected)
        
        myListButton.addTarget(self, action: #selector(didTapMyListButton), for: .touchUpInside)
    }
}
