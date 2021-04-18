//
//  MovieRoutes.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import Moya

protocol MovieRoutesProtocol {
    func getDetails(movieId: Int, completion: @escaping Completion)
    func getSimilar(movieId: Int, page: Int, completion: @escaping Completion)
}

struct MovieRoutes {

    enum Target: APITarget {
        case getDetails(movieId: Int)
        case getSimilar(movieId: Int, page: Int)

        var path: String {
            switch self {
            case let .getDetails(movieId):
                return "/movie/\(movieId)".appendBaseQuery()
            case let .getSimilar(movieId, page):
                return "/movie/\(movieId)/similar".appendBaseQueryWith(["page": page])
            }
        }

        var method: Method {
            switch self {
            case .getDetails:
                return .get
            case .getSimilar:
                return .get
            }
        }

        var task: Task {
            switch self {
            case .getDetails:
                return .requestPlain
            case .getSimilar:
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
    
    func getSimilar(movieId: Int, page: Int, completion: @escaping Completion) {
        provider.request(.getSimilar(movieId: movieId, page: page), completion: completion)
    }
}
