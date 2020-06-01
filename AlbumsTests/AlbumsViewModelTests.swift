//
//  AlbumsViewModelTests.swift
//  AlbumsTests
//
//  Created by Sujan Kanna on 5/30/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import XCTest
import Combine
@testable import Albums

class AlbumsViewModelTests: XCTestCase {

    var service: MockAlbumsService!
    var viewModel: AlbumsViewModel!
    var mockResponse: MockResponse!
    
    override func setUpWithError() throws {
        service = MockAlbumsService()
        mockResponse = MockResponse()
        viewModel = AlbumsViewModel(albumsService: service)
    }

    override func tearDownWithError() throws {
        mockResponse = nil
        service = nil
        viewModel = nil
    }

    func testValidResponse() throws {
        service.result = mockResponse.validReponsePublisher()
        viewModel.fetchAlbums()
        
        let completedExpectation = expectation(description: "Completed")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completedExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        if let albums = viewModel!.albums {
            let album = mockResponse.sampleAlbum()
            let albumViewModel = AlbumViewModel(album: album)
            XCTAssertEqual(albums, [albumViewModel])
        } else {
            XCTAssert(false, "No albums")
        }
    }
    
    func testInValidResponse() throws {
        service.result = mockResponse.invalidReponsePublisher()
        viewModel.fetchAlbums()
        
        let completedExpectation = expectation(description: "Completed")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completedExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        if let error = viewModel!.error {
            let parsingError = APIError.parsing(description: "The data couldn’t be read because it isn’t in the correct format.")
            XCTAssertEqual(parsingError.localizedDescription, error.localizedDescription)
        } else {
            XCTAssert(false, "No error")
        }
    }
    
}
