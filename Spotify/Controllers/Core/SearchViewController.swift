//
//  SearchViewController.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import UIKit

class SearchViewController: UIViewController, UISearchControllerDelegate ,UISearchBarDelegate{
 
    
    private let searchController : UISearchController = {
        let vc = UISearchController(searchResultsController: SerachResultsViewController())
        vc.searchBar.placeholder = "Song, Artist, Album"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()
    
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { (_, _) -> NSCollectionLayoutSection? in
        
        let item = NSCollectionLayoutItem(
            layoutSize:
                NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize:
                NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(120)),
            subitem: item,
            count: 2
        )
        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 2, bottom: 10, trailing: 2)
        return NSCollectionLayoutSection(group: group)
        
    }))
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        
        setupUI()
    }
    
    func setupUI(){
        
//        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identify)
        view.addSubview(collectionView)
        collectionView.fitToSuper()
        ServerData()
    }
    
    func ServerData(){
        ApiCaller.shared.getCategories { [weak self] result in
            DispatchQueue.main.async {
                //                print(result)
                switch result {
                case .success(let model):
                    
                    self?.categories = model.items ?? []
                    
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
   
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let query : String
        guard let resultSearchController = searchController.searchResultsController as? SerachResultsViewController,
              let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
//        print(resultSearchController)
//        print(query)
        
        resultSearchController.delegate = self
        
        ApiCaller.shared.searchPlayList(with: query) { result in
            switch result {
            case .success(let model):
                print(model)
 
                resultSearchController.updateResult(with:model)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identify, for: indexPath) as! SearchCollectionViewCell
        
        let category = self.categories[indexPath.row]
        cell.configureUI(
            for:CategoryCollectionViewModel(
                title: category.name ?? "",
                artWork: URL(string: category.icons?.first?.url ?? "")
            )
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = self.categories[indexPath.row]
        let vc = CategoryListVC(category: category)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
 
extension SearchViewController:  SearchResultViewControllerDelegate{
    func didTapResult(_ results: SearchResult) {
        switch results {
        case .albums(mode:let model):
            let vc =  NewReleasePlayListVC(album: model)
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .artists(mode:let model):
            print(model)
//            cell.textLabel?.text = model.name
        case .tracks(mode:let model):
            print(model)
//            cell.textLabel?.text = model.name
        case .playlists(mode:let model):
 
            let vc = FeaturePlayListVC(playList: model)
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
 
            
        }
    }
    
  
    
}
 
