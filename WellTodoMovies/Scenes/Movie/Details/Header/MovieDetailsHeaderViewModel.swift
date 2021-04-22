//
//  MovieDetailsHeaderViewModel.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 22/04/21.
//

import Foundation

class MovieDetailsHeaderViewModel: MovieDetailsHeaderViewModelProtocol {

    var isLiked: Bool = false
    
    var onLikeChange: ((Bool) -> Void)?
    
    var posterURL: URL {
        return APIHost.baseImageURL.appendingPathComponent(String())
    }
    var title: String {
        return "Guilhermo Del Toro's Movie Recommendations"
    }
    var likes: String {
        return "916 Likes"
    }
    var popularity: String {
        return "1 of 274 Watched"
    }
    
    func likeButtonClick() {
        isLiked = !isLiked
        onLikeChange?(isLiked)
    }
}
