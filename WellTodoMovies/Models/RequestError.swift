//
//  RequestError.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import Foundation

struct RequestError: Decodable {
    var statusMessage: String
    var statusCode: Int
}

extension RequestError {
    
    static func defaultError() -> RequestError {
        return RequestError(statusMessage: "error.request.decode".localized(context: .default), statusCode: 422)
    }
}
