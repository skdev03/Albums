//
//  AlbumsViewController.swift
//  Albums
//
//  Created by Sujan Kanna on 5/28/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import UIKit
import Combine

class AlbumsViewController: UIViewController {

    private var tableView: UITableView = UITableView()
    
    private var loaderView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    weak var coordinator: MainCoordinator?
    
    let viewModel: AlbumsViewModelable!
    var albums: [AlbumViewModel] = []
    private var disposables = Set<AnyCancellable>()
    
    init(viewModel: AlbumsViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupBindings()
        loaderView.startAnimating()
        viewModel.fetchAlbums()
    }

}

extension AlbumsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.identifier, for: indexPath) as? AlbumCell else {
            return UITableViewCell()
        }
        
        cell.update(album: albums[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let album = albums[indexPath.row]
        coordinator?.showAlbumDetail(for: album)
    }
    
}

// MARK:- Helpers
extension AlbumsViewController {
    private func setupView() {
        view.backgroundColor = .white
        title = "Albums"
        
        setupTableView()
        loaderView.center = view.center
        view.addSubview(loaderView)
    }
    
    private func setupTableView() {
        tableView.register(AlbumCell.self, forCellReuseIdentifier: AlbumCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topPadding: 0, leftPadding: 0, bottomPadding: 0, rightPadding: 0)
    }
    
    private func setupBindings() {
        viewModel.$albums
            .filter { $0 != nil }
            .sink { [weak self] (albums) in
            guard let albums = albums else {
                return
            }

            self?.loaderView.stopAnimating()
            if !albums.isEmpty {
                self?.albums = albums
                self?.tableView.reloadData()
            }
        }
        .store(in: &disposables)

        viewModel.$error.sink { [weak self] (error) in
            self?.loaderView.stopAnimating()
            if let error = error {
                switch error {
                case .networkNotReachable:
                    self?.showAlert(title: nil, message: "Please connect to the internet and try again.")
                default:
                    break
                }
            }
        }
        .store(in: &disposables)
    }
    
    private func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        navigationController?.present(alertController, animated: true)
    }
}
