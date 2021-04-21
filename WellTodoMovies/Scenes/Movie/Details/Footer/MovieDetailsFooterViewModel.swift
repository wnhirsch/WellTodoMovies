//
//  MovieDetailsFooterViewModel.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 21/04/21.
//

import Foundation

class MovieDetailsFooterViewModel: MovieDetailsFooterViewModelProtocol {
    
    var isLiked: Bool = false
    var isOnMyLists: Bool = false
    
    var onLikeChange: ((Bool) -> Void)?
    var onMyListsChange: ((Bool) -> Void)?
    
    func likeButtonClick() {
        isLiked = !isLiked
        onLikeChange?(isLiked)
    }
    
    func myListButtonClick() {
        if !isOnMyLists {
            isOnMyLists = true
            onMyListsChange?(isOnMyLists)
        }
    }
}
