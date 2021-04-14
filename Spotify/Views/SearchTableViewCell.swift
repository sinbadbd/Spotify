//
//  SearchTableViewCell.swift
//  Spotify
//
//  Created by Imran on 14/4/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let indentify = "SearchTableViewCell"
    
    
    let imageViewArt : UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    let titleLbl : UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(imageViewArt)
        addSubview(titleLbl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
