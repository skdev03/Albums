//
//  MockResponse.swift
//  AlbumsTests
//
//  Created by Sujan Kanna on 5/31/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import Foundation
import Combine
@testable import Albums

class MockResponse {
    func sampleAlbum() -> Album {
        let genre1 = Genre(name: "Urbano latino")
        let genre2 = Genre(name: "Music")
        let genre3 = Genre(name: "Latino")
        let genres = [genre1, genre2, genre3]
        let album = Album(id: "1512629429", name: "LAS QUE NO IBAN A SALIR", artistName: "Bad Bunny", artworkUrl100: "https://music.apple.com/us/album/las-que-no-iban-a-salir/1512629429?app=music", url: "https://is2-ssl.mzstatic.com/image/thumb/Music113/v4/1e/12/a3/1e12a343-737a-eb33-5a52-a47ee9423beb/195081580067.jpg/200x200bb.png", releaseDate: "2020-05-10", genres: genres, copyright: "℗ 2020 Rimas Entertainment")
        
        return album
    }
    
    func validReponsePublisher() -> AnyPublisher<[Album], APIError> {
        return Just(Data(MockAlbumsResponse.validResponse.utf8))
            .decode(type: MainResponse.self, decoder: JSONDecoder())
            .map { $0.feed.results }
            .mapError { .parsing(description: $0.localizedDescription) }
            .eraseToAnyPublisher()
    }
    
    func invalidReponsePublisher() -> AnyPublisher<[Album], APIError> {
        return Just(Data(MockAlbumsResponse.invalidResponse.utf8))
            .decode(type: MainResponse.self, decoder: JSONDecoder())
            .map { $0.feed.results }
            .mapError { .parsing(description: $0.localizedDescription) }
            .eraseToAnyPublisher()
    }
}

struct MockAlbumsResponse {
    static let validResponse = """
{
   "feed":{
      "results":[
         {
            "artistName":"Bad Bunny",
            "id":"1512629429",
            "releaseDate":"2020-05-10",
            "name":"LAS QUE NO IBAN A SALIR",
            "kind":"album",
            "copyright":"℗ 2020 Rimas Entertainment",
            "artistId":"1126808565",
            "contentAdvisoryRating":"Explicit",
            "artistUrl":"https://music.apple.com/us/artist/bad-bunny/1126808565?app=music",
            "artworkUrl100":"https://is2-ssl.mzstatic.com/image/thumb/Music113/v4/1e/12/a3/1e12a343-737a-eb33-5a52-a47ee9423beb/195081580067.jpg/200x200bb.png",
            "genres":[
               {
                  "genreId":"1119",
                  "name":"Urbano latino",
                  "url":"https://itunes.apple.com/us/genre/id1119"
               },
               {
                  "genreId":"34",
                  "name":"Music",
                  "url":"https://itunes.apple.com/us/genre/id34"
               },
               {
                  "genreId":"12",
                  "name":"Latino",
                  "url":"https://itunes.apple.com/us/genre/id12"
               }
            ],
            "url":"https://music.apple.com/us/album/las-que-no-iban-a-salir/1512629429?app=music"
         }
      ]
   }
}
"""
    static let invalidResponse = """
"""
}
