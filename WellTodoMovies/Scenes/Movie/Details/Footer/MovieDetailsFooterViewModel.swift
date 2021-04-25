//
//  MovieDetailsFooterViewModel.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 21/04/21.
//

import Foundation

class MovieDetailsFooterViewModel: MovieDetailsFooterViewModelProtocol {
    
    private var onLikeChange: ((Bool) -> Void)?
    
    var isLiked: Bool = false
    var isOnMyLists: Bool = false
    
    var onUpdateLikeButton: ((Bool) -> Void)?
    var onUpdateMyListsButton: ((Bool) -> Void)?
    
    init(isLiked: Bool, onLikeChange: ((Bool) -> Void)?) {
        self.isLiked = isLiked
        self.onLikeChange = onLikeChange
    }

    
    func likeButtonClick() {
        isLiked = !isLiked
        onUpdateLikeButton?(isLiked)
        onLikeChange?(isLiked)
    }
    
    func myListButtonClick() {
        if !isOnMyLists {
            isOnMyLists = true
            onUpdateMyListsButton?(isOnMyLists)
        }
    }
}
