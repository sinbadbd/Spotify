//
//  CategoryListVC.swift
//  Spotify
//
//  Created by Imran on 4/4/21.
//

import UIKit

class CategoryListVC: UIViewController {

    var playList = [PlayList]()
    var category : Category
    
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
                    heightDimension: .absolute(140)),
            subitem: item,
            count: 2
        )
        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 2, bottom: 10, trailing: 2)
        return NSCollectionLayoutSection(group: group)
        
    }))
    
    init(category: Category) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = category.name
        
        view.addSubview(collectionView)
 
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.fitToSuper()
        collectionView.backgroundColor = .white
        self.collectionView.register(FeatureCollectionViewCell.self, forCellWithReuseIdentifier: FeatureCollectionViewCell.indetifer)
        serverData()
    }
    
    func serverData(){
        ApiCaller.shared.getCategoriesPlayList(category: category) { result in
            DispatchQueue.main.async {
                //                print(result)
                switch result {
                case .success(let model):
                    self.playList = model
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
 

}

extension CategoryListVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureCollectionViewCell.indetifer, for: indexPath) as! FeatureCollectionViewCell
        
        let list = playList[indexPath.row]
        
        cell.configureCell(viewModel: FeaturedPlayListModelView(name: list.name, artWorkURL: URL(string: list.images.first?.url ?? "")))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let list = playList[indexPath.row]
        
        let vc = FeaturePlayListVC(playList: list)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
