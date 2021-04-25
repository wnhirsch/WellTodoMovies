//
//  MovieDetailsViewModel.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//


import Foundation

protocol MovieDetailsProtocol: MovieDetailsViewModelProtocol {
    var onTapSimilarMovie: ((Movie) -> Void)? { get set }
    
    var onStartGetMovieDetails: (() -> Void)? { get set }
    var onSuccessGetMovieDetails: (() -> Void)? { get set }
    var onFailureGetMovieDetails: ((String) -> Void)? { get set }
    
    var onFailureGetSimilarMovies: ((String) -> Void)? { get set }
    
    func fetchMovie()
}

class MovieDetailsViewModel: MovieDetailsProtocol {
    
    private let movieID: Int
    private let getMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol
    private let getSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol
    
    private var isLiked: Bool = false
    private var movie: Movie?
    private var movieDetails: MovieDetails? {
        didSet {
            onChangeMovieHeader?(headerViewModel)
        }
    }
    
    private var actualPage: Int = 1
    private var totalPages: Int = 1
    private var cachedSimilarMovies: [Movie] = []
    var isLoadingSimilarMovies: Bool = false
    
    var onStartGetMovieDetails: (() -> Void)?
    var onSuccessGetMovieDetails: (() -> Void)?
    var onFailureGetMovieDetails: ((String) -> Void)?
    
    var onChangeMovieHeader: ((MovieDetailsHeaderViewModelProtocol) -> Void)?
    var onChangeMovieFooter: ((MovieDetailsFooterViewModelProtocol) -> Void)?
    
    var onStartGetSimilarMovies: (() -> Void)?
    var onFailureGetSimilarMovies: ((String) -> Void)?
    var onEndGetSimilarMovies: (() -> Void)?
    var onSetSimilarMovies: ((SimilarMovieSection) -> Void)?
    var onAppendSimilarMovies: ((SimilarMovieSection) -> Void)?
    var onTapSimilarMovie: ((Movie) -> Void)?

    init(movieID: Int, getMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol,
         getSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol) {
        self.movieID = movieID
        self.getMovieDetailsUseCase = getMovieDetailsUseCase
        self.getSimilarMoviesUseCase = getSimilarMoviesUseCase
    }
    
    init(movie: Movie, getMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol,
         getSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol) {
        self.movieID = movie.id
        self.movie = movie
        self.getMovieDetailsUseCase = getMovieDetailsUseCase
        self.getSimilarMoviesUseCase = getSimilarMoviesUseCase
    }
    
    var headerViewModel: MovieDetailsHeaderViewModelProtocol {
        return MovieDetailsHeaderViewModel(movie: movie ?? movieDetails?.toMovie(),
                                           isLiked: isLiked, onLikeChange: updateTableFooter)
    }
    var footerViewModel: MovieDetailsFooterViewModelProtocol {
        return MovieDetailsFooterViewModel(isLiked: isLiked, onLikeChange: updateTableHeader)
    }
    
    private func updateTableHeader(isLiked: Bool) {
        self.isLiked = isLiked
        onChangeMovieHeader?(headerViewModel)
    }
    private func updateTableFooter(isLiked: Bool) {
        self.isLiked = isLiked
        onChangeMovieFooter?(footerViewModel)
    }
    
    func clickMovie(movie: Movie) {
        onTapSimilarMovie?(movie)
    }
}

extension MovieDetailsViewModel {
    
    func fetchMovie() {
        if movie == nil {
            fetchMovieDetails()
        } else {
            fetchSimilarMovies()
        }
    }
    
    func fetchMovieDetails() {
        onStartGetMovieDetails?()
        
        getMovieDetailsUseCase.execute(id: movieID, success: { [weak self] movieDetails in
            self?.movieDetails = movieDetails
            self?.onSuccessGetMovieDetails?()
            self?.fetchSimilarMovies()
        }, failure: { [weak self] error in
            self?.onFailureGetMovieDetails?(error.statusMessage)
        })
    }
    
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
        onStartGetSimilarMovies?()
        
        getSimilarMoviesUseCase.execute(id: movieID, page: actualPage, success: { [weak self] movies in
            self?.totalPages = 1 // Comment this line
//            self?.totalPages = movies.totalPages // and uncomment this line
            self?.handleSuccess(movies: movies.results)
            self?.isLoadingSimilarMovies = false
        }, failure: { [weak self] error in
            self?.onFailureGetSimilarMovies?(error.statusMessage)
            self?.onEndGetSimilarMovies?()
            self?.isLoadingSimilarMovies = false
        })
    }
    
    private func handleSuccess(movies: [Movie]) {
        cachedSimilarMovies.append(contentsOf: movies)
        let section = SimilarMovieSection(viewModels: movies.map({ SimilarMovieCellViewModel(movie: $0, onClick: clickMovie)
        }))
        
        if actualPage > 1 {
            onAppendSimilarMovies?(section)
        } else {
            onSetSimilarMovies?(section)
        }
    }
}
