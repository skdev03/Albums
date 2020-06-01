//
//  BaseViewModel.swift
//  Albums
//
//  Created by Sujan Kanna on 5/31/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import Foundation
import Combine

class BaseViewModel {
    @Published var albums: [AlbumViewModel]?
    @Published var error: APIError?
}
