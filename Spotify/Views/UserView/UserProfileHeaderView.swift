//
//  UserProfileHeaderView.swift
//  Spotify
//
//  Created by Imran on 10/3/21.
//

import UIKit

//MARK: Protocol to get reuse ID
public protocol Reuseable {
    static func ReuseID() -> String
}

class UserProfileHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier: String = String(describing: self)
    
    
    let userImage : UIImageView = {
        let image = UIImageView()
//        image.layer.maskedCorners = true
        return image
        
    }()
    
 
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundColor = .red
//        addSubview(userImage)
        contentView.addSubview(userImage)
        userImage.centerXInSuper()
        userImage.size(width:80,height: 80)
        userImage.layer.cornerRadius = 40
        userImage.backgroundColor = .blue
        
    }
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
}

//Reusable protocol for views
extension UserProfileHeaderView: Reuseable {
    static func ReuseID() -> String {
        return String(describing: self)
    }
}

