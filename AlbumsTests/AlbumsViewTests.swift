//
//  AlbumsViewTests.swift
//  AlbumsTests
//
//  Created by Sujan Kanna on 5/31/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import XCTest
import Combine
@testable import Albums

class AlbumsViewTests: XCTestCase {

    var albumsViewController: AlbumsViewController!
    var service: MockAlbumsService!
    var viewModel: AlbumsViewModel!
    var mockResponse: MockResponse!
    private var disposables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        service = MockAlbumsService()
        mockResponse = MockResponse()
        viewModel = AlbumsViewModel(albumsService: service)
    }

    override func tearDownWithError() throws {
        mockResponse = nil
        service = nil
        viewModel = nil
        albumsViewController = nil
    }

    func testValidAlbums() throws {
        albumsViewController = AlbumsViewController(viewModel: viewModel)
        service.result = mockResponse.validReponsePublisher()
        albumsViewController.viewDidLoad()
        
        let completedExpectation = expectation(description: "Completed")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completedExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        let expectedAlbumViewModel = AlbumViewModel(album: mockResponse.sampleAlbum())
        var albumViewModels: [AlbumViewModel] = []
        viewModel.$albums
            .filter { $0 != nil }
            .sink { result in
            albumViewModels = result ?? []
        }
        .store(in: &disposables)
        
        XCTAssertEqual(albumViewModels, [expectedAlbumViewModel])
    }
    
    func testInvalidAlbums() throws {
        albumsViewController = AlbumsViewController(viewModel: viewModel)
        service.result = mockResponse.validReponsePublisher()
        albumsViewController.viewDidLoad()
        
        let completedExpectation = expectation(description: "Completed")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completedExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        let expectedAlbumViewModel = AlbumViewModel(album: mockResponse.sampleAlbum())
        var error: APIError?
        viewModel.$error
            .filter { $0 != nil }
            .sink { result in
            error = result
        }
        .store(in: &disposables)
        
//        XCTAssertEqual(error?.localizedDescription, [expectedAlbumViewModel])
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
