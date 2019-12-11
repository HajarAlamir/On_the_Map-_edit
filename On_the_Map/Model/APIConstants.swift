//
//  APIConstants.swift
//  On_the_Map
//
//  Created by Hajar F on 11/5/19.
//  Copyright © 2019 Hajar F. All rights reserved.
//

import Foundation

struct APIConstants {
    
    struct HeaderKeys {
        static let PARSE_APP_ID = "X-Parse-Application-Id"
        static let PARSE_API_KEY = "X-Parse-REST-API-Key"
        
    }
    
    struct HeaderValues {
        static let PARSE_APP_ID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let PARSE_API_KEY = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    }
    
    struct ParameterKeys {
        static let LIMIT = "limit"
        static let SKIP = "skip"
        static let ORDER = "order"
    }
    
    private static let MAIN = "https://onthemap-api.udacity.com"
    static let SESSION = "https://onthemap-api.udacity.com/v1/session"
    static let PUBLIC_USER = "https://onthemap-api.udacity.com/v1/users/"
    static let STUDENT_LOCATION = MAIN + "/v1/StudentLocation"
    
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}
