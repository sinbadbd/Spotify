//
//  PlaylistHeaderCollectionViewReuseCell.swift
//  Spotify
//
//  Created by Imran on 26/3/21.
//

import UIKit
import SDWebImage

class PlaylistHeaderCollectionViewReuseCell: UICollectionReusableView {
    static let identifier = "PlaylistHeaderCollectionViewReuseCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
