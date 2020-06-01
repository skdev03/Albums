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
        
        albumImageView.anchor(top: topAnchor, topPadding: 8, left: leftAnchor, leftPadding: 8, bottom: bottomAnchor, bottomPadding: 8, right: nil, rightPadding: 0, width: 50, height: 50)
        albumNameLabel.anchor(top: topAnchor, topPadding: 8, left: albumImageView.rightAnchor, leftPadding: 8, bottom: nil, bottomPadding: 0, right: rightAnchor, rightPadding: 32)
        artistNameLabel.anchor(top: albumNameLabel.bottomAnchor, topPadding: 4, left: albumImageView.rightAnchor, leftPadding: 8, bottom: nil, bottomPadding: 0, right: rightAnchor, rightPadding: 32, width: 0, height: 21)
    }
}


