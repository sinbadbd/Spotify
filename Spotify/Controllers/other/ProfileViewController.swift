//
//  ProfileViewController.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    
    private var models = [String]()
    var imageURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        serverData()
        setProfileUI()
    }
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    func setProfileUI(){
        view.addSubview(tableView)
        
        tableView.fitToSuper()
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.isHidden = true
        registerViewsToTableView()
    }
    private func registerViewsToTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UserProfileHeaderCell.self, forCellReuseIdentifier: "header")
        
    }
    
    func serverData(){
        ApiCaller.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let model):
                    print(model)
                    self?.updateUI(with: model)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func updateUI(with model: UserProfile ){
        //        tableView.isHidden = false
        models.append("Full Name: \(model.display_name)")
        models.append("Country: \(model.country)")
        models.append("Email: \(model.country)")
        models.append("User Id: \(model.id)")
        imageURL = model.images.first?.url ?? ""
        tableView.reloadData()
    }
    
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = models[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cellModel
        return cell
        
    }
    
    //MARK: Section View Handling
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "header") as? UserProfileHeaderCell
        cell?.userImage.sd_setImage(with: URL(string: imageURL))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
        
    }
    
}


