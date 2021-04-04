//
//  LibraryViewController.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import UIKit
import Lottie

class LibraryViewController: UIViewController {
    private var animationView: AnimationView?

    func setupLoadingAnimation(){
        // 2. Start AnimationView with animation name (without extension)
          
          animationView = .init(name: "coffee")
          
          animationView!.frame = view.bounds
          
          // 3. Set animation content mode
          
          animationView!.contentMode = .scaleAspectFit
          
          // 4. Set animation loop mode
          
          animationView!.loopMode = .loop
          
          // 5. Adjust animation speed
          
          animationView!.animationSpeed = 0.5
          
          view.addSubview(animationView!)
          
          // 6. Play animation
          
          animationView!.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupLoadingAnimation()
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
