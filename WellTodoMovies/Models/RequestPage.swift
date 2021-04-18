//
//  RequestPage.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import Foundation

struct RequestPage<T: Decodable>: Decodable {
    var page: Int
    var results: [T]
    var totalPages: Int
    var totalResults: Int
}
