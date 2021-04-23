//
//  String+Localizable.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 18/04/21.
//

import Foundation

enum LocalizableFiles: String {
    case `default` = "Default"
    case movieDetailsHeader = "MovieDetailsHeader"
    case movieDetailsFooter = "MovieDetailsFooter"
}

extension String {

    func localized(context: LocalizableFiles) -> String {
        return NSLocalizedString(self, tableName: context.rawValue, value: "", comment: "")
    }

    func localizedWithArgs(context: LocalizableFiles, _ args: [CVarArg]) -> String {
        return String(format: localized(context: context), arguments: args)
    }
}
