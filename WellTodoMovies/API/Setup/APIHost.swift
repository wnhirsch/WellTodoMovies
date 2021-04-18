//
//  APIHost.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import Foundation

enum APIHost {
    
    static var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/")!
    }
    
    static var apiKey: String {
        return "a767131adda7e3bbc22369a6e3b2bae4"
    }
    
    static var language: String {
        return Locale.autoupdatingCurrent.languageCode ?? "en-US"
    }
}
