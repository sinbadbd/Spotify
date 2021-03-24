//
//  FeatureCollectionViewCell.swift
//  Spotify
//
//  Created by Imran on 20/3/21.
//

import UIKit

class FeatureCollectionViewCell: UICollectionViewCell {
    static let indetifer = "FeatureCollectionViewCell"
    
    let songImage = UIImageView()
    let songTitle  = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        addSubview(songImage)
        addSubview(songTitle)
        
        
        songImage.position(top: topAnchor, left: leadingAnchor, insets: .init(top: 0, left: 10, bottom: 0, right: 10))
        songImage.backgroundColor = .blue
        songImage.size(width:150, height: 80)
        
        songTitle.position(top: songImage.bottomAnchor, left: leadingAnchor, bottom: bottomAnchor,right:trailingAnchor ,insets: .init(top: 5, left: 10, bottom: 0, right: 20))
        songTitle.backgroundColor = .red
        songTitle.numberOfLines = 0

        
        
//        songTitle.
        
    }
    
    func configureCell(viewModel: FeaturedPlayListModelView){
//        let url = URL(string: "\(viewModel.artWorkURL ?? "")")
//        self.songImage.sd_setImage(with: viewModel.artWorkURL, completed: nil)
//        self.songTitle.text = viewModel.name
        
        
        
        let attributes = Helper.getAttributedText(string: "\(viewModel.name)" , font: UIFont.boldSystemFont(ofSize: 16), color: .black, lineSpace: 5, alignment: .left)
//        let attributes2 = Helper.getAttributedText(string: "\n\(viewModel.artistName)" , font: UIFont.systemFont(ofSize: 14),color: .black, lineSpace: 5, alignment: .left)
//        let attributes3 = Helper.getAttributedText(string: "\n\n\(viewModel.numberOfTracks)" , font: UIFont.boldSystemFont(ofSize: 18),color: .darkGray, lineSpace: 0, alignment: .left)
//         attributes.append(attributes2)
//        attributes.append(attributes3)
        self.songTitle.attributedText = attributes
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
