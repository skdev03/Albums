//
//  AlbumCell.swift
//  Albums
//
//  Created by Sujan Kanna on 5/29/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import UIKit

protocol CellIdentifiable {
    static var identifier: String { get }
}

class AlbumCell: UITableViewCell, CellIdentifiable {

    static var identifier: String {
        return "AlbumCell"
    }
    
    private var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()
    
    private var artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(album: AlbumViewModel) {
        albumNameLabel.text = album.name
        artistNameLabel.text = album.artistName
        
        if let url = URL(string: album.artworkUrl100) {
            let placeholderImage = UIImage(named: "Placeholder")
            albumImageView.loadImage(from: url, placeholder: placeholderImage)
        }
    }
}

// MARK:- Helpers
extension AlbumCell {
    private func setupViews() {
        addSubview(albumNameLabel)
        addSubview(artistNameLabel)
        addSubview(albumImageView)
        
        albumImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topPadding: 5, leftPadding: 8, bottomPadding: 5, rightPadding: 0, topPriority: .init(rawValue: 999), width: 50, height: 50)
        albumNameLabel.anchor(top: topAnchor, left: albumImageView.rightAnchor, bottom: nil, right: rightAnchor, topPadding: 5, leftPadding: 8, bottomPadding: 0, rightPadding: 32)
        artistNameLabel.anchor(top: albumNameLabel.bottomAnchor, left: albumImageView.rightAnchor, bottom: nil, right: rightAnchor, topPadding: 4, leftPadding: 8, bottomPadding: 0, rightPadding: 32, height: 21)
    }
}


