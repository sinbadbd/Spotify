//
//  FeatureCollectionViewCell.swift
//  Spotify
//
//  Created by Imran on 20/3/21.
//

import UIKit

class FeatureCollectionViewCell: UICollectionViewCell {
    static let indetifer = "FeatureCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
