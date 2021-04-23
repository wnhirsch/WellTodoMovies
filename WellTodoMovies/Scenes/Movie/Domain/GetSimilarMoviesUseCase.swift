//
//  GetSimilarMoviesUseCase.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import Foundation

protocol GetSimilarMoviesUseCaseProtocol {
    typealias Success = ((RequestPage<Movie>) -> Void)
    typealias Failure = ((RequestError) -> Void)

    func execute(id: Int, page: Int, success: Success?, failure: Failure?)
}

class GetSimilarMoviesUseCase: GetSimilarMoviesUseCaseProtocol {

    private let api: MovieRoutesProtocol

    init(api: MovieRoutesProtocol) {
        self.api = api
    }

    func execute(id: Int, page: Int, success: Success? = nil, failure: Failure? = nil) {
        api.getSimilar(movieId: id, page: page) { result in
            switch result {
            case let .success(response):
                do {
                    let movies = try response.mapObject(RequestPage<Movie>.self)
                    success?(movies)
                } catch let error {
                    print(error)
                    failure?(RequestError.defaultError())
                }
            case let .failure(error):
                do {
                    let serverError = try error.response!.mapObject(RequestError.self)
                    failure?(serverError)
                } catch let error {
                    print(error)
                    failure?(RequestError.defaultError())
                }
            }
        }
    }
}
