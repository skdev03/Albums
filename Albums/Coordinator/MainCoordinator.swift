//
//  MainCoordinator.swift
//  Albums
//
//  Created by Sujan Kanna on 5/28/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import UIKit
import Foundation

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let albumsViewModel = AlbumsViewModel(albumsService: AlbumsService())
        let albumsVC = AlbumsViewController(viewModel: albumsViewModel)
        albumsVC.coordinator = self
        navigationController.pushViewController(albumsVC, animated: true)
    }
    
    func showAlbumDetail(for album: AlbumViewModel) {
        let albumDetailVC = AlbumDetailViewController(album: album)
        navigationController.pushViewController(albumDetailVC, animated: true)
    }
}
