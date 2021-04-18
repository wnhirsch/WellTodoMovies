//
//  Collection.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import Foundation

struct Collection: Decodable {
    var id: Int
    var name: String
    var posterPath: String?
    var backdropPath: String?
}
