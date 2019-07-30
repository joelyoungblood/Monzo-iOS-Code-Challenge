//
//  AppConstants.swift
//  Headlines
//
//  Created by Joel Youngblood on 6/7/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

struct AppConstants {
    static let apiKey = "enj8pstqu5yat6yesfsdmd39"
    static let rootUrl = "http://content.guardianapis.com/" //we could also define roots for differant environments here, but clearly unessecary for this example
    static let favouritesNavNotification = Notification(name: Notification.Name("goToFavourites"))
}
