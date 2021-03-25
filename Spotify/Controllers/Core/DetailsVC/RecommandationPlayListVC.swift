//
//  RecommandationPlayListVC.swift
//  Spotify
//
//  Created by Imran on 24/3/21.
//

import UIKit

class RecommandationPlayListVC: UIViewController {

    private var audioTrack : AudioTrack
    
    init(audioTrack: AudioTrack) {
        self.audioTrack = audioTrack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = audioTrack.name
        view.backgroundColor = .blue
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
