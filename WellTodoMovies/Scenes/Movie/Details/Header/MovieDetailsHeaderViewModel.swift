//
//  MovieDetailsHeaderViewModel.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 22/04/21.
//

import Foundation

class MovieDetailsHeaderViewModel: MovieDetailsHeaderViewModelProtocol {

    private let movie: Movie?
    var isLiked: Bool = false
    
    var onLikeChange: ((Bool) -> Void)?
    
    init(movie: Movie?) {
        self.movie = movie
    }
    
    var posterURL: URL {
        return APIHost.baseImageURL.appendingPathComponent(movie?.posterPath ?? String())
    }
    var title: String {
        return movie?.title ?? " "
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
        return "\(movie?.popularity ?? 0.0)%"
    }
    
    func likeButtonClick() {
        isLiked = !isLiked
        onLikeChange?(isLiked)
    }
}
