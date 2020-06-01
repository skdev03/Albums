//
//  AlbumDetailViewController.swift
//  Albums
//
//  Created by Sujan Kanna on 5/29/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {

    private let album: AlbumViewModel
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    private var artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = .systemBlue
        return label
    }()
    
    private var genresLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = .systemGray
        return label
    }()
    
    private var copyrightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    private var albumPageButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5.0
        button.backgroundColor = .systemBlue
        button.setTitle("Show Album", for: .normal)
        return button
    }()
    
    init(album: AlbumViewModel) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        populateViews()
        albumPageButton.addTarget(self, action: #selector(showAlbum), for: .touchUpInside)
    }

}

// MARK:- Helpers
extension AlbumDetailViewController {
    private func setupView() {
        title = "Album"
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(albumNameLabel)
        view.addSubview(artistNameLabel)
        view.addSubview(genresLabel)
        view.addSubview(copyrightLabel)
        view.addSubview(albumPageButton)
        
        imageView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, topPadding: 100, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 200, height: 200)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        albumNameLabel.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topPadding: 8, leftPadding: 16, bottomPadding: 0, rightPadding: 16)
        artistNameLabel.anchor(top: albumNameLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topPadding: 4, leftPadding: 16, bottomPadding: 0, rightPadding: 16)
        genresLabel.anchor(top: artistNameLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topPadding: 4, leftPadding: 16, bottomPadding: 0, rightPadding: 16)
        copyrightLabel.anchor(top: genresLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topPadding: 16, leftPadding: 16, bottomPadding: 0, rightPadding: 16)
        albumPageButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topPadding: 0, leftPadding: 20, bottomPadding: 20, rightPadding: 20, width: 0, height: 44)
    }
    
    private func populateViews() {
        if let url = URL(string: album.artworkUrl100) {
            let placeholderImage = UIImage(named: "Placeholder")
            imageView.loadImage(from: url, placeholder: placeholderImage)
        }
        
        albumNameLabel.text = album.name
        artistNameLabel.text = album.artistName
        genresLabel.text = album.genresReleaseDate
        copyrightLabel.text = album.copyright
    }
    
    @objc
    private func showAlbum() {
        if let url = URL(string: album.url) {
            UIApplication.shared.open(url)
        }
    }
}
