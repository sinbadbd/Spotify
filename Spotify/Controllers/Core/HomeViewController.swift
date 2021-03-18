//
//  ViewController.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navHeader()
        getServerData()
    }
    func navHeader(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .done, target: self, action: #selector(didTapSettings))
    }

    private func getServerData(){
        ApiCaller.shared.GetRecommandationGenres {[weak self] result in
            DispatchQueue.main.async {
                //print("result:::===\(result)")
                switch result{
                case .success(let model):
                    let geners = model.genres
                    var seed = Set<String>()
                    while seed.count < 5 {
                        if let random = geners.randomElement(){
                            seed.insert(random)
                        }
                    }
                    print(model)
                    
                    ApiCaller.shared.GetRecommendations(geners: seed) { result in
                        print("result-recommand:\(result)")
                    }
                    
                    
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    @objc func didTapSettings(){
        let vc = SettingsViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

}

