//
//  MovieRoutes.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import Moya

protocol MovieRoutesProtocol {
    func getDetails(movieId: Int, completion: @escaping Completion)
}

struct MovieRoutes {

    enum Target: APITarget {
        case getDetails(movieId: Int)

        var path: String {
            switch self {
            case let .getDetails(movieId):
                return "/movie/\(movieId)".appendBaseQuery()
            }
        }

        var method: Method {
            switch self {
            case .getDetails:
                return .get
            }
        }

        var task: Task {
            switch self {
            case .getDetails:
                return .requestPlain
            }
        }

        var headers: [String: String]? {
           return sessionHeader()
        }
    }

    private let provider: MoyaProvider<Target> = APIProvider<Target>().build()
}

extension MovieRoutes: MovieRoutesProtocol {
    
    func getDetails(movieId: Int, completion: @escaping Completion) {
        provider.request(.getDetails(movieId: movieId), completion: completion)
    }
}
