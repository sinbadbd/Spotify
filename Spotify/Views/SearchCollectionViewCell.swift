//
//  SearchCollectionViewCell.swift
//  Spotify
//
//  Created by Imran on 30/3/21.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    static let identify = "SearchCollectionViewCell"
     
    private var colors:[UIColor] = [
        .systemBlue,
        .systemGreen,
        .systemIndigo,
        .systemOrange,
        .systemPink,
        .systemPurple,
        .systemRed,
        .systemTeal,
        .systemYellow
    ]
    
    private let imageIcon : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "music.note.list")
        image.tintColor = .white
        return image
    }()
    
    let titleLbl : UILabel = {
        let text = UILabel()
        text.textColor = .white
        return text
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    func setupUI(){
        contentView.layer.cornerRadius = 4
        addSubview(imageIcon)
        imageIcon.position(top:topAnchor ,right: trailingAnchor,insets: .init(top: 10, left: 0, bottom: 0, right: 10))
        imageIcon.size(width:60,height: 60)
        addSubview(titleLbl)
        titleLbl.position( left: leadingAnchor, bottom: bottomAnchor, insets: .init(top: 0, left: 10, bottom: 10, right: 0))
    }
    
    func configureUI(for title: String){
       titleLbl.text = title
        contentView.backgroundColor = colors.randomElement()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
