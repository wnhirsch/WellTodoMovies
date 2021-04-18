//
//  String+Moya.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import Foundation

extension String {
    
    func appendBaseQuery() -> String {
        return self + "?api_key=\(APIHost.apiKey)&language=\(APIHost.language)"
    }
    
    func appendBaseQueryWith(_ queries: [String: Any]) -> String {
        var path = self.appendBaseQuery()
        for (query, value) in queries {
            path.append("&\(query)=\(String(describing: value))")
        }
        return path
    }
}
