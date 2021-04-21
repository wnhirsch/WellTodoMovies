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
    
    func likeButtonClick() {
        isLiked = !isLiked
    }
    
    func myListButtonClick() {
        isOnMyLists = !isOnMyLists
    }
}
