//
//  MockAlbumsService.swift
//  AlbumsTests
//
//  Created by Sujan Kanna on 5/31/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import Foundation
import Combine
@testable import Albums

class MockAlbumsService: AlbumsFindable {
    var feedCount: Int = 0
    
    var result: AnyPublisher<[Album], APIError>!
    
    func albums() -> AnyPublisher<[Album], APIError> {
        return result.eraseToAnyPublisher()
    }
}
