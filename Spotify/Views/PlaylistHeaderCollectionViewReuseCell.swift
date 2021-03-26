//
//  PlaylistHeaderCollectionViewReuseCell.swift
//  Spotify
//
//  Created by Imran on 26/3/21.
//

import UIKit
import SDWebImage

protocol PlaylistHeaderCollectionReusableViewDelegate: AnyObject {
    func playlistHeaderCollectionReuseableDidTapPlayAll(_ header: PlaylistHeaderCollectionViewReuseCell)
}


class PlaylistHeaderCollectionViewReuseCell: UICollectionReusableView {
    static let identifier = "PlaylistHeaderCollectionViewReuseCell"
    
    
    weak var delegate : PlaylistHeaderCollectionReusableViewDelegate?
    
    let artisCoverImage : UIImageView =  {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
        
    }()
    
    let playLisTitle : UILabel = {
        let label = UILabel()
        return label
        
    }()
    
    let playButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .red
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.alpha = 0.4
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        setupUI()
    }
    
    
    func setupUI(){
        addSubview(artisCoverImage)
        addSubview(playLisTitle)
        artisCoverImage.position(top:topAnchor)
        artisCoverImage.centerXInSuper()
        artisCoverImage.size(width:200,height: 200)
        artisCoverImage.backgroundColor = .blue
        
        playLisTitle.position(top: artisCoverImage.bottomAnchor, left: leadingAnchor, bottom: bottomAnchor, right: trailingAnchor, insets: .init(top: 20, left: 20, bottom: 20, right: 20))
        playLisTitle.numberOfLines = 0
        playLisTitle.sizeToFit()
//        playLisTitle.backgroundColor = .systemRed
        playLisTitle.text = "Rock legends and epic songs that cintune ti inspire generations"
        
        addSubview(playButton)
        playButton.position( bottom: bottomAnchor, right: trailingAnchor, insets: .init(top: 0, left: 0, bottom: 10, right: 10))
        playButton.size(width:40, height: 40)
        playButton.addTarget(self, action: #selector(didTapPlayAll), for: .touchUpInside)
//        playButton.backgroundColor = .green
    }
    
    func configureCell(with viewModel: PlaylistHeaderViewModel){
        self.artisCoverImage.sd_setImage(with: viewModel.artworkURL, completed: nil)
//        self.songTitle.text = viewModel.name
        
        
        
        let attributes = Helper.getAttributedText(string: "\(viewModel.name ?? "")" , font: UIFont.boldSystemFont(ofSize: 16), color: .black, lineSpace: 5, alignment: .left)
        let attributes2 = Helper.getAttributedText(string: "\n\(viewModel.ownName ?? "")" , font: UIFont.systemFont(ofSize: 14),color: .black, lineSpace: 5, alignment: .left)
        let attributes3 = Helper.getAttributedText(string: "\n\n\(viewModel.description ?? "")" , font: UIFont.boldSystemFont(ofSize: 18),color: .darkGray, lineSpace: 0, alignment: .left)
         attributes.append(attributes2)
        attributes.append(attributes3)
        self.playLisTitle.attributedText = attributes
    }
    
    
    @objc private func didTapPlayAll(_ sender:UIButton){
        UIView.animate(withDuration: 0.2) {
            sender.alpha = 0.5
        } completion: {_ in
            sender.alpha = 1
        }
        self.delegate?.playlistHeaderCollectionReuseableDidTapPlayAll(self)

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
