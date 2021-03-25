//
//  NewReleasePlayListVC.swift
//  Spotify
//
//  Created by Imran on 24/3/21.
//

import UIKit

class NewReleasePlayListVC: UIViewController {
    
    private var album : Album
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .green
        title = album.name
        // Do any additional setup after loading the view.
        
        serverData()
    }
    
    private func serverData(){
        ApiCaller.shared.getAlbumDetails(from: album) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    print(model)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

}
