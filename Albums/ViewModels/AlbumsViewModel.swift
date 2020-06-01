//
//  AlbumsViewModel.swift
//  Albums
//
//  Created by Sujan Kanna on 5/29/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import Foundation
import Combine

protocol AlbumsViewModelable: BaseViewModel {
    func fetchAlbums()
}

class AlbumsViewModel: BaseViewModel, AlbumsViewModelable {
    private var albumsService: AlbumsFindable
    private var disposables = Set<AnyCancellable>()
    
    init(albumsService: AlbumsFindable) {
        self.albumsService = albumsService
        self.albumsService.feedCount = 100
    }
    
    func fetchAlbums() {
        guard Reachability().isNetworkReachable() else {
            error = APIError.networkNotReachable
            return
        }
        
        albumsService.albums().receive(on: DispatchQueue.main)
            .map { return $0.map { AlbumViewModel(album: $0) } }
            .sink(
                receiveCompletion: { [weak self] value in
                    switch value {
                    case .failure(let error):
                        self?.error = error
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] albums in
                    self?.albums = albums
            })
            .store(in: &disposables)
    }
}
