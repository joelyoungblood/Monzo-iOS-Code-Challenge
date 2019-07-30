//
//  HeadlinesError.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/7/19.
//  Copyright © 2019 Example. All rights reserved.
//

//Normally I'd have including CustomDebugStringConvertible here too, for additional debug details, but time constraints means this error handling is in general limited
protocol HeadlinesError: Error, CustomStringConvertible { }

enum NetworkError: HeadlinesError {
    case noConnection
    case formationError(url: String)
    case errorCode(code: Int)
    case invalidStatus
    
    var description: String {
        switch self {
        case .noConnection:
            return "No internet connection detected. If you are not seeing any data, the initial sync must not have been performed. Please check your connectionn and refresh."
        case .formationError(let url):
            return "Failed to form a correct URL for path \(url)"
        case .errorCode(let code):
            return "There was a network error, server returned response code - \(code)"
        case .invalidStatus:
            return "There was an error returned by the API"
        }
    }
}

enum RealmError: HeadlinesError {
    case noData
    case connectionError
    case save(error: Error, elements: Any)
    
    var description: String {
        switch self {
        case .noData:
            return "There was no data synced to the Realm DB - please check your internet connection and refresh."
        case .connectionError:
            return "Unable to connect to the Realm DB"
        case .save(let error, let elements):
            return "Error \(error.localizedDescription) while saving objects \(String(describing: elements))"
        }
    }
}

enum DecodeError<T>: HeadlinesError {
    case decode(error: Error)
    
    var description: String {
        switch self {
        case .decode(let error):
            return "Decoding model of type \(T.self) failed with error \(error.localizedDescription)"
        }
    }
}

