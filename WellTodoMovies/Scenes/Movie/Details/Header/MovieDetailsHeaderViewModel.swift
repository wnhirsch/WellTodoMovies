//
//  MovieDetailsHeaderViewModel.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 22/04/21.
//

import Foundation

class MovieDetailsHeaderViewModel: MovieDetailsHeaderViewModelProtocol {

    private let movie: Movie?
    private var onLikeChange: ((Bool) -> Void)?
    var isLiked: Bool = false
    
    var onUpdateLikeButton: ((Bool) -> Void)?
    
    init(movie: Movie?, isLiked: Bool, onLikeChange: ((Bool) -> Void)?) {
        self.movie = movie
        self.isLiked = isLiked
        self.onLikeChange = onLikeChange
    }
    
    var posterURL: URL {
        return APIHost.baseImageURL.appendingPathComponent(movie?.posterPath ?? String())
    }
    var title: String {
        return movie?.title ?? String()
    }
    var likes: String {
        guard let voteCount = movie?.voteCount else {
            return "likes.zero".localized(context: .movieDetailsHeader)
        }
        
        if voteCount == 0 {
            return "likes.zero".localized(context: .movieDetailsHeader)
        } else if voteCount == 1 {
            return "likes.one".localized(context: .movieDetailsHeader)
        } else if voteCount < 1000 {
            return "likes.hundreds".localizedWithArgs(context: .movieDetailsHeader, [voteCount])
        } else if voteCount < 1000000 {
            return "likes.thousands".localizedWithArgs(context: .movieDetailsHeader, [Double(voteCount) / 1000])
        } else {
            return "likes.millions".localizedWithArgs(context: .movieDetailsHeader, [Double(voteCount) / 1000000])
        }
    }
    var popularity: String {
        if let popularity = movie?.popularity, popularity >= 1.0 {
            return "views.default".localizedWithArgs(context: .movieDetailsHeader, [popularity])
        } else {
            return "views.zero".localized(context: .movieDetailsHeader)
        }
    }
    
    func likeButtonClick() {
        isLiked = !isLiked
        onUpdateLikeButton?(isLiked)
        onLikeChange?(isLiked)
    }
}
