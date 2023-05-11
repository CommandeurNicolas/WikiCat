//
//  MyIntentError.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 11/05/2023.
//

import Foundation

enum MyIntentError: Swift.Error, CustomLocalizedStringResourceConvertible {
    case general
    case message(_ message: String)

    var localizedStringResource: LocalizedStringResource {
        switch self {
        case let .message(message): return "\(message)"
        case .general: return "My general error"
        }
    }
}
