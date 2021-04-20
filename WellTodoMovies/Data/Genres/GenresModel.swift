//
//  GenresModel.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 20/04/21.
//

import Foundation

struct GenresModel: Decodable {
    var genres: [Genre]
}

extension GenresModel {
    
    struct Genre: Decodable {
        var id: Int
        var name: String
    }
}
