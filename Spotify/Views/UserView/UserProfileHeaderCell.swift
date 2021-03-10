//
//  UserProfileHeaderCell.swift
//  Spotify
//
//  Created by Imran on 10/3/21.
//

import UIKit
import SDWebImage

class UserProfileHeaderCell: UITableViewCell {

    let userImage : UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
        
    }()
    
    
    private var model : UserProfile?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray6
        addSubview(userImage)
        userImage.centerXInSuper()
        userImage.centerYInSuper()
        userImage.size(width:100,height: 100)
        userImage.layer.cornerRadius = 50
        userImage.backgroundColor = .systemGray
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
 

}
