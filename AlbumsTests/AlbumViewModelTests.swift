//
//  AlbumViewModelTests.swift
//  AlbumsTests
//
//  Created by Sujan Kanna on 5/30/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import XCTest
@testable import Albums

class AlbumViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testAlbumViewModel() {
        let album = MockResponse().sampleAlbum()
        let albumViewModel = AlbumViewModel(album: album)
        XCTAssertEqual(album.name, albumViewModel.name)
        XCTAssertEqual(album.artistName, albumViewModel.artistName)
        XCTAssertEqual(album.artworkUrl100, albumViewModel.artworkUrl100)
        XCTAssertEqual(album.url, albumViewModel.url)
        XCTAssertEqual(album.copyright, albumViewModel.copyright)
        
        let genres = album.genres.map { $0.name }.joined(separator: ", ")
        XCTAssertEqual("\(genres) . \(album.releaseDate)", albumViewModel.genresReleaseDate)
    }
}
