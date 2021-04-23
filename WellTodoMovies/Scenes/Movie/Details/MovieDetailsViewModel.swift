//
//  MovieDetailsViewModel.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//


import Foundation

protocol MovieDetailsProtocol: MovieDetailsViewModelProtocol {
    var onTapSimilarMovie: ((Movie) -> Void)? { get set }
    
    func fetchMovie()
}

class MovieDetailsViewModel: MovieDetailsProtocol {
    
    private let movieID: Int
    private let getMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol
    private let getSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol
    
    private var movie: Movie?
    private var movieDetails: MovieDetails? {
        didSet {
            onChangeMovieDetails?(headerViewModel)
        }
    }
    
    private var actualPage: Int = 1
    private var totalPages: Int = 1
    private var cachedSimilarMovies: [Movie] = []
    var isLoadingSimilarMovies: Bool = false
    
    var onChangeMovieDetails: ((MovieDetailsHeaderViewModelProtocol) -> Void)?
    
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
        return MovieDetailsHeaderViewModel(movie: movie ?? movieDetails?.toMovie())
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
        getMovieDetailsUseCase.execute(id: movieID, success: { [weak self] movieDetails in
            self?.movieDetails = movieDetails
            self?.fetchSimilarMovies()
        }, failure: { error in
            print(error.statusMessage)
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
        getSimilarMoviesUseCase.execute(id: movieID, page: actualPage, success: { [weak self] movies in
            self?.totalPages = 1 // movies.totalPages
            self?.handleSuccess(movies: movies.results)
            self?.isLoadingSimilarMovies = false
        }, failure: { [weak self] error in
            print(error.statusMessage)
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
