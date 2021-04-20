//
//  GetGenreListUseCase.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 20/04/21.
//

import Foundation

protocol GetMovieGenreListUseCaseProtocol {
    typealias Success = ((GenresModel) -> Void)
    typealias Failure = ((RequestError) -> Void)

    func execute(success: Success?, failure: Failure?)
}

class GetMovieGenreListUseCase: GetMovieGenreListUseCaseProtocol {

    private let api: GenreRoutesProtocol

    init(api: GenreRoutesProtocol) {
        self.api = api
    }

    func execute(success: Success? = nil, failure: Failure? = nil) {
        api.getForMovies { (result) in
            switch result {
            case let .success(response):
                do {
                    let genres = try response.mapObject(GenresModel.self)
                    success?(genres)
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
