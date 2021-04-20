//
//  GenreRoutes.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 20/04/21.
//

import Moya

protocol GenreRoutesProtocol {
    func getForMovies(completion: @escaping Completion)
}

struct GenreRoutes {

    enum Target: APITarget {
        case getForMovies

        var path: String {
            switch self {
            case .getForMovies:
                return "/genre/movie/list".appendBaseQuery()
            }
        }

        var method: Method {
            switch self {
            case .getForMovies:
                return .get
            }
        }

        var task: Task {
            switch self {
            case .getForMovies:
                return .requestPlain
            }
        }

        var headers: [String: String]? {
           return sessionHeader()
        }
    }

    private let provider: MoyaProvider<Target> = APIProvider<Target>().build()
}

extension GenreRoutes: GenreRoutesProtocol {
    
    func getForMovies(completion: @escaping Completion) {
        provider.request(.getForMovies, completion: completion)
    }
}
