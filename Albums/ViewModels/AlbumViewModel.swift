//
//  AlbumViewModel.swift
//  Albums
//
//  Created by Sujan Kanna on 5/30/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import Foundation

struct AlbumViewModel {
    let id: String
    let name: String
    let artistName: String
    let artworkUrl100: String
    let url: String
    let genresReleaseDate: String
    let copyright: String
    
    init(album: Album) {
        self.id = album.id
        self.name = album.name
        self.artistName = album.artistName
        self.artworkUrl100 = album.artworkUrl100
        self.url = album.url
        self.copyright = album.copyright
        
        let genres = album.genres.map { $0.name }.joined(separator: ", ")
        genresReleaseDate = "\(genres) . \(album.releaseDate)"
    }
}

extension AlbumViewModel: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
