//
//  AlbumsService.swift
//  Albums
//
//  Created by Sujan Kanna on 5/29/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import Foundation
import Combine

//https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json

protocol AlbumsFindable {
    var feedCount: Int { get set }
    
    func albums() -> AnyPublisher<[Album], APIError>
}

class AlbumsService {
    private let session: URLSession
    var feedCount: Int = 100
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension AlbumsService: AlbumsFindable {
    func albums() -> AnyPublisher<[Album], APIError> {
        let urlComponents = makeAlbumsDownloadComponents(feedCount: feedCount)
        
        guard let url = urlComponents.url else {
            let error = APIError.failure(description: "Could not create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        return session.dataTaskPublisher(for: request)
        .mapError { error in
            return .failure(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { (data, response) -> AnyPublisher<MainResponse, APIError> in
            return decode(data)
        }
        .map({ (response) -> [Album] in
            return response.feed.results
        })
        .eraseToAnyPublisher()
    }
}

extension AlbumsService {
    struct AlbumsServiceAPI {
        static let scheme = "https"
        static let host = "rss.itunes.apple.com"
        static let path = "/api/v1/us/apple-music/top-albums/all/"
    }
    
    func makeAlbumsDownloadComponents(feedCount: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = AlbumsServiceAPI.scheme
        components.host = AlbumsServiceAPI.host
        components.path = AlbumsServiceAPI.path + "\(feedCount)/explicit.json"
        return components
    }
}

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, APIError> {
    let decoder = JSONDecoder()
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}
