//
//  GetMovieDetailsUseCase.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import Foundation

protocol GetMovieDetailsUseCaseProtocol {
    typealias Success = ((MovieDetails) -> Void)
    typealias Failure = ((RequestError) -> Void)

    func execute(id: Int, success: Success?, failure: Failure?)
}

class GetMovieDetailsUseCase: GetMovieDetailsUseCaseProtocol {

    private let api: MovieRoutesProtocol

    init(api: MovieRoutesProtocol) {
        self.api = api
    }

    func execute(id: Int, success: Success? = nil, failure: Failure? = nil) {
        api.getDetails(movieId: id) { result in
            switch result {
            case let .success(response):
                do {
                    let movie = try response.mapObject(MovieDetails.self)
                    success?(movie)
                } catch let error {
                    print(error)
                    failure?(RequestError.defaultError())
                }
            case let .failure(error):
                if let response = error.response {
                    do {
                        let serverError = try response.mapObject(RequestError.self)
                        failure?(serverError)
                    } catch let error {
                        print(error)
                        failure?(RequestError.defaultError())
                    }
                } else {
                    print(error)
                    failure?(RequestError.defaultError())
                }
            }
        }
    }
}
