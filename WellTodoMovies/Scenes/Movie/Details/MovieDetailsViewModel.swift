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
}

class MovieDetailsViewModel: MovieDetailsProtocol {
    
    private let getSimilarMoviesUseCase: GetSimilarMoviesUseCase
    private var actualPage: Int = 1
    private var totalPages: Int = 1
    private var cachedSimilarMovies: [Movie] = []
    var isLoadingSimilarMovies: Bool = false
    
    var onStartGetSimilarMovies: (() -> Void)?
    var onEmptyGetSimilarMovies: (() -> Void)?
    var onSuccessGetSimilarMovies: (() -> Void)?
    var onFailureGetSimilarMovies: ((String) -> Void)?
    
    var onSetSimilarMovies: ((SimilarMovieSection) -> Void)?
    var onAppendSimilarMovies: ((SimilarMovieSection) -> Void)?
    var onTapSimilarMovie: ((Movie) -> Void)?
    
    init(getSimilarMoviesUseCase: GetSimilarMoviesUseCase) {
        self.getSimilarMoviesUseCase = getSimilarMoviesUseCase
    }
    
    func clickMovie(movie: Movie) {
        
    }
}

extension MovieDetailsViewModel {
    
    func fetchSimilarMovies() {
        isLoadingSimilarMovies = true
        cachedSimilarMovies.removeAll()
        actualPage = 1
        getSimilarMovies()
    }
    
    func fetchMoreSimilarMovies() {
        if actualPage < totalPages {
            isLoadingSimilarMovies = true
            actualPage += 1
            getSimilarMovies()
        }
    }
    
    private func getSimilarMovies() {
        if cachedSimilarMovies.isEmpty {
            onStartGetSimilarMovies?()
        }
        
        getSimilarMoviesUseCase.execute(id: 550, page: actualPage, success: { [weak self] movies in
            self?.totalPages = movies.totalPages
            self?.handleSuccess(movies: movies.results)
            self?.isLoadingSimilarMovies = false
        }, failure: { [weak self] (error) in
            self?.onFailureGetSimilarMovies?(error.statusMessage)
            self?.isLoadingSimilarMovies = false
        })
    }
    
    private func handleSuccess(movies: [Movie]) {
        cachedSimilarMovies.append(contentsOf: movies)
        let section = SimilarMovieSection(viewModels: movies.map({ SimilarMovieCellViewModel(movie: $0, onClick: clickMovie)
        }))
        
//        print(movies.map({ $0.originalTitle }))
        
        if actualPage > 1 {
            onAppendSimilarMovies?(section)
        } else {
            if cachedSimilarMovies.isEmpty {
                onEmptyGetSimilarMovies?()
            } else {
                onSuccessGetSimilarMovies?()
            }
            onSetSimilarMovies?(section)
        }
    }
}
