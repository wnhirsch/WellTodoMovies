//
//  MovieDetailsViewModel.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//


import Foundation

protocol MovieDetailsProtocol: MovieDetailsViewModelProtocol {
    var onTapSimilarMovie: ((Movie) -> Void)? { get set }
    
    var onStartGetSimilarMovies: (() -> Void)? { get set }
    var onEmptyGetSimilarMovies: (() -> Void)? { get set }
    var onSuccessGetSimilarMovies: (() -> Void)? { get set }
    var onFailureGetSimilarMovies: ((String) -> Void)? { get set }
    
    func fetchSimilarMovies()
    func loadMoreSimilarMovies()
}

class MovieDetailsViewModel: MovieDetailsProtocol {
    
    private let getSimilarMoviesUseCase: GetSimilarMoviesUseCase
    private var actualPage: Int = 1
    
    var cachedSimilarMovies: [Movie] = []
    
    var onStartGetSimilarMovies: (() -> Void)?
    var onEmptyGetSimilarMovies: (() -> Void)?
    var onSuccessGetSimilarMovies: (() -> Void)?
    var onFailureGetSimilarMovies: ((String) -> Void)?
    
    var onChangeSimilarMovies: (() -> Void)?
    var onTapSimilarMovie: ((Movie) -> Void)?
    
    init(getSimilarMoviesUseCase: GetSimilarMoviesUseCase) {
        self.getSimilarMoviesUseCase = getSimilarMoviesUseCase
    }
    
//    var movieHeaderViewModel: MovieHeaderViewModelProtocol {
//        return MovieHeaderViewModel()
//    }
//    var similarMovieViewModels: [SimilarMovieViewModelProtocol] {
//        return [SimilarMovieViewModel()]
//    }
    
    func clickMovie() {
        // TODO
    }
}

extension MovieDetailsViewModel {
    
    func fetchSimilarMovies() {
        cachedSimilarMovies.removeAll()
        actualPage = 1
        getSimilarMovies()
    }
    
    func loadMoreSimilarMovies() {
        actualPage += 1
        getSimilarMovies()
    }
    
    private func getSimilarMovies() {
        if cachedSimilarMovies.isEmpty {
            onStartGetSimilarMovies?()
        }
        
        getSimilarMoviesUseCase.execute(id: 550, page: actualPage, success: { [weak self] movies in
            self?.handleSuccess(movies: movies.results)
        }, failure: { [weak self] (error) in
            self?.onFailureGetSimilarMovies?(error.statusMessage)
        })
    }
    
    private func handleSuccess(movies: [Movie]) {
        cachedSimilarMovies.append(contentsOf: movies)
        print(movies)
        
        onChangeSimilarMovies?()
        if cachedSimilarMovies.isEmpty {
            onEmptyGetSimilarMovies?()
        } else {
            onSuccessGetSimilarMovies?()
        }
    }
}
