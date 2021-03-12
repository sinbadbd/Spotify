//
//  ViewController.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import UIKit
import AVFoundation
import AVKit


class HomeViewController: UIViewController {
    
    var playPauseButton: PlayPauseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navHeader()
        playerUI()
    }
    func navHeader(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .done, target: self, action: #selector(didTapSettings))
    }
    
    @objc func didTapSettings(){
        let vc = SettingsViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func playerUI(){
        guard let url = URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/1080/Big_Buck_Bunny_1080_10s_1MB.mp4") else { return }
        
        let player = AVPlayer(url: url)
        player.rate = 1 //auto play
        let playerFrame = CGRect(x: 0, y: 200, width: view.frame.width, height: 200)
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.view.frame = playerFrame
        playerViewController.showsPlaybackControls = true
        print("playerFrame:\(playerViewController.view.frame)")
        
        
        addChild(playerViewController)
        view.addSubview(playerViewController.view)
        playerViewController.didMove(toParent: self)
//        playerViewController.addObserver(self, forKeyPath: "videoBounds", options: NSKeyValueObservingOptions.new, context: nil)

        
        playPauseButton = PlayPauseButton()
        playPauseButton.avPlayer = player
        
        
        //        playerViewController.view = playPauseButton
        //        view.addSubview(playPauseButton)
        
        playerViewController.contentOverlayView?.addSubview(playPauseButton)
        playerViewController.contentOverlayView!.addObserver(self, forKeyPath: "videoBounds", options: NSKeyValueObservingOptions.new, context: nil)

        playPauseButton.size(width:100, height: 100)
        playPauseButton.setup(in: self)
        playPauseButton.clipsToBounds = true
        
    }
    var isVideoInFullScreen = false
    func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutableRawPointer) {

        if keyPath == "videoBounds"  {
            let rect = change!["new"] as! NSValue

            if let playerRect: CGRect = rect.cgRectValue as? CGRect {
                if playerRect.size == UIScreen.main.bounds.size {
                    print("Player in full screen")
                    isVideoInFullScreen = true
                } else {
                    print("Player not in full screen")
                }
            }
        }
    }
 
    
    /*
    func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutableRawPointer) {
        print("KeyPath \(String(describing: keyPath))")
        if keyPath == "videoBounds" {
            print("New Video Bounds \(String(describing: change))")
        }
    }*/
    
    
    func currentVideoFrameSize(playerView: UIView, player: AVPlayer) -> CGSize {
        // See https://stackoverflow.com/a/40164496/1877617
        let track = player.currentItem?.asset.tracks(withMediaType: .video).first
        if let track = track {
            let trackSize      = track.naturalSize
            let videoViewSize  = playerView.bounds.size
            let trackRatio     = trackSize.width / trackSize.height
            let videoViewRatio = videoViewSize.width / videoViewSize.height
            
            var newSize: CGSize
            
            if videoViewRatio > trackRatio {
                newSize = CGSize(width: trackSize.width * videoViewSize.height / trackSize.height, height: videoViewSize.height)
            } else {
                newSize = CGSize(width: videoViewSize.width, height: trackSize.height * videoViewSize.width / trackSize.width)
            }
            
            return newSize
        }
        return CGSize.zero
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        playPauseButton.updateUI()
    }
}


class PlayPauseButton: UIView {
    var kvoRateContext = 0
    var avPlayer: AVPlayer?
    var isPlaying: Bool {
        return avPlayer?.rate != 0 && avPlayer?.error == nil
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        setBackgroundImage(name: "pngegg")
        
//        setBackgroundImage(name: "pngegg")
//
//        updatePosition()
//        //        updateUI()
//        addObservers()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addObservers() {
        avPlayer?.addObserver(self, forKeyPath: "rate", options: .new, context: &kvoRateContext)
    }
    
    func setup(in container: UIViewController) {
        //        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
        //        addGestureRecognizer(gesture)
        addObservers()
        setBackgroundImage(name: "pngegg")
        
        updatePosition()
        updateUI()
    
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        //        updateStatus()
        //        updateUI()
    }
    
    private func updateStatus() {
        if isPlaying {
            avPlayer?.play()
            //           avPlayer?.pause()
        }
        
        //        else {
        //            avPlayer?.play()
        //        }
    }
    
    func updateUI() {
        if isPlaying {
            setBackgroundImage(name: "pngegg")
        } else {
            setBackgroundImage(name: "pngegg")
        }
    }
    
    func updatePosition() {
        guard let logoView = superview else { return }
        guard let codeText = superview else { return }

        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 200),
            heightAnchor.constraint(equalToConstant: 200),
            leadingAnchor.constraint(equalTo: logoView.leadingAnchor,constant: 40),
            topAnchor.constraint(equalTo: logoView.topAnchor,constant: 50)
        ])
        
//        NSLayoutConstraint.activate([
//            widthAnchor.constraint(equalToConstant: codeText.frame.width-20),
//            heightAnchor.constraint(equalToConstant: 50),
//            leadingAnchor.constraint(equalTo: codeText.leadingAnchor,constant: 40),
//            topAnchor.constraint(equalTo: codeText.bottomAnchor,constant: 50)
//        ])
//        codeText.backgroundColor = .red
    }
    
    private func setBackgroundImage(name: String) {
        UIGraphicsBeginImageContext(frame.size)
        UIImage(named: name)?.draw(in: bounds)
//        UIImage.init(named: <#T##String#>, in: <#T##Bundle?#>, with: <#T##UIImage.Configuration?#>)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        backgroundColor = UIColor(patternImage: image)
    }
    
    private func handleRateChanged() {
        updateUI()
        
        
        
//
//        setBackgroundImage(name: "pngegg")
//
//        updatePosition()
//        //        updateUI()
//        addObservers()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let context = context else { return }
        
        switch context {
        case &kvoRateContext:
            handleRateChanged()
        default:
            break
        }
    }
}
