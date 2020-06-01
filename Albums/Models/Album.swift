//
//  Album.swift
//  Albums
//
//  Created by Sujan Kanna on 5/29/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import Foundation

struct MainResponse: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let results: [Album]
}

struct Album: Codable {
    let id: String
    let name: String
    let artistName: String
    let artworkUrl100: String
    let url: String
    let releaseDate: String
    let genres: [Genre]
    let copyright: String
}

struct Genre: Codable {
    let name: String
}
