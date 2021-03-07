//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Spotify"
        view.backgroundColor  = .systemGreen
        // Do any additional setup after loading the view.
        
        view.addSubview(signInButton)
        signInButton.position( left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, insets: .init(top: 0, left: 40, bottom: 40, right: 40))
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        
    }
 
    
    private let signInButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    
    @objc func didTapSignIn(_ sender: UIButton){
        let vc = AuthViewController()
        vc.completionHandle = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    
    private func handleSignIn(success: Bool){

    }
    
}
