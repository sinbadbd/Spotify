//
//  TitleHeaderCollectionView.swift
//  Spotify
//
//  Created by Imran on 28/3/21.
//

import UIKit

class TitleHeaderCollectionView: UICollectionReusableView {
    static let identify = "TitleHeaderCollectionView"
    
    
    let headerTitle : UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 20)
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .red
        addSubview(headerTitle)
        headerTitle.fitToSuper()
        headerTitle.position( insets: .init(top: 0, left: 20, bottom: 10, right: 0))
    }
    
    func configureHeaderTitle(with title: String) {
        headerTitle.text = title
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
