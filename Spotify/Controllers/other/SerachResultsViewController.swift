//
//  SerachResultsViewController.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import UIKit


struct SearchSection {
    let title : String
    let results: [SearchResult]
}

protocol SearchResultViewControllerDelegate: AnyObject {
    func  showResult(_ viewController:UIViewController)
}

class SerachResultsViewController: UIViewController {
    
    private var searchResult : [SearchSection] = []
    
    weak var delegate: SearchResultViewControllerDelegate?
    
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
    }
    private func setupUI(){
        view.addSubview(tableView)
        tableView.fitToSuper()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
    }
    
    func updateResult(with results: [SearchResult]) {
        let artist = results.filter({
            switch $0{
            case .artists: return true
            default :return false
            }
        })
        let album = results.filter({
            switch $0{
            case .albums: return true
            default :return false
            }
        })
        let tracks = results.filter({
            switch $0{
            case .tracks: return true
            default :return false
            }
        })
        let playList = results.filter({
            switch $0{
            case .playlists: return true
            default :return false
            }
        })
        self.searchResult = [
            SearchSection(title: "Artist)", results: artist),
            SearchSection(title: "Album)", results: album),
            SearchSection(title: "Tracks)", results: tracks),
            SearchSection(title: "PlayList)", results: playList)
        ]
 
        DispatchQueue.main.async { [self] in
            
            if  self.searchResult.count > 0{ 
                tableView.reloadData()
                tableView.isHidden = results.isEmpty
            }
        }
    }
}
extension SerachResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  searchResult[section].results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let data = searchResult[indexPath.section].results[indexPath.item]
        
        switch data {
        case .albums(mode:let model):
         cell.textLabel?.text = model.name
        case .artists(mode:let model):
            cell.textLabel?.text = model.name
        case .tracks(mode:let model):
            cell.textLabel?.text = model.name
        case .playlists(mode:let model):
            cell.textLabel?.text = model.name
 
            
        }
        
         return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let data = searchResult[section].title
 
        return data
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let data = searchResult[indexPath.section].results[indexPath.item]
        print(data)
        switch data {
        case .albums(mode:let model):
            let vc =  NewReleasePlayListVC(album: model)
            navigationController?.pushViewController(vc, animated: true)
        case .artists(mode:let model):
            print(model)
//            cell.textLabel?.text = model.name
        case .tracks(mode:let model):
            print(model)
//            cell.textLabel?.text = model.name
        case .playlists(mode:let model):
            print(model)
//            cell.textLabel?.text = model.name
 
            
        }
    }
}
