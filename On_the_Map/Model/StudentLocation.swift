//
//  StudentLocation.swift
//  On_the_Map
//
//  Created by Hajar F on 11/5/19.
//  Copyright © 2019 Hajar F. All rights reserved.
//

import Foundation


struct StudentLocation: Codable {
    
    var createdAt: String?
    var firstName: String?
    var lastName: String?
    var latitude: Double?
    var longitude: Double?
    var mapString: String?
    var mediaURL: String?
    var objectId: String?
    var uniqueKey: String?
    var updatedAt: String?
  
}

extension StudentLocation {
    init(mapString: String, mediaURL: String) {
        self.mapString = mapString
        self.mediaURL = mediaURL
    }
}



enum SLParam: String {
    case createdAt
    case firstName
    case lastName
    case latitude
    case longitude
    case mapString
    case mediaURL
    case objectId
    case uniqueKey
    case updatedAt
}


