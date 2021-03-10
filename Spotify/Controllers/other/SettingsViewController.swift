//
//  SettingsViewController.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettingUI()
    }
    func setupSettingUI(){
        view.addSubview(tableView)
        view.backgroundColor = .white
        tableView.fitToSuper()
        tableView.delegate = self
        tableView.dataSource = self
        configureModels()
        
    }
    private func configureModels(){
        sections.append(Section(title: "Profile", option:  [Option(title: "View Your Profile", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.viewProfile()
            }
        })]))
        
        sections.append(Section(title: "Account", option:  [Option(title: "Sign Out", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.singoutAcc()
            }
        })]))
        
    }
    private func viewProfile(){
        let vc = ProfileViewController()
        vc.title = "Profile"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    private func singoutAcc(){
        
    }
    
    let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.backgroundColor = .red
         return tableView
    }()
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].option.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.row].option[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = sections[indexPath.row].option[indexPath.row]
        model.handler()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
    
}
