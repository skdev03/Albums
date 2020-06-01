//
//  APIError.swift
//  Albums
//
//  Created by Sujan Kanna on 5/29/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import Foundation

enum APIError: Error {
    case parsing(description: String)
    case failure(description: String)
    case networkNotReachable
}
