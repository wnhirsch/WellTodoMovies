//
//  String+Date.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 19/04/21.
//

import Foundation

extension String {

    func toDate(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZ") -> Date? {
        let parseFormat = DateFormatter()
        parseFormat.timeZone = TimeZone.current
        parseFormat.locale = Locale.current
        parseFormat.dateFormat = format
        return parseFormat.date(from: self)
    }
}

extension Date {
    
    static var rawDateFormat: String {
        "yyyy-MM-dd"
    }
    static var defaultDateFormat: String {
        "dd/MM/yyyy"
    }
    static var yearFormat: String {
        "yyyy"
    }

    func toString(format: String = Date.defaultDateFormat, timeZone: TimeZone = .current, locale: Locale = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
}
