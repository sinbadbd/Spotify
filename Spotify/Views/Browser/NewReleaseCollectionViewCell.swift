//
//  NewReleaseCollectionViewCell.swift
//  Spotify
//
//  Created by Imran on 20/3/21.
//

import UIKit
import SDWebImage

class NewReleaseCollectionViewCell: UICollectionViewCell {
    static let indetifer = "NewReleaseCollectionViewCell"
    
    let songImage = UIImageView()
    let songTitle  = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(songImage)
        addSubview(songTitle)
        
        songImage.position(top: topAnchor, left: leadingAnchor, bottom: bottomAnchor)
        songImage.backgroundColor = .blue
        songImage.size(width:120, height: 80)
        
        songTitle.position(top: topAnchor, left: songImage.trailingAnchor, right:trailingAnchor ,insets: .init(top: 5, left: 10, bottom: 0, right: 20))
        
        songTitle.numberOfLines = 0
//        songTitle.
        
    }
    
    func configureCell(viewModel: NewReleaseCellViewModel){
//        let url = URL(string: "\(viewModel.artWorkURL ?? "")")
        self.songImage.sd_setImage(with: viewModel.artWorkURL, completed: nil)
        self.songTitle.text = viewModel.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
