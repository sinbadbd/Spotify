//
//  NewReleasePlayListVC.swift
//  Spotify
//
//  Created by Imran on 24/3/21.
//

import UIKit

class NewReleasePlayListVC: UIViewController {
    
    private var album : Album
    
    private var viewModel = [RecommandViewModel]()

    
    private var collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ -> NSCollectionLayoutSection? in
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(80)
            ),
            subitem: item,
            count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize:
                    NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalWidth(1)
                    ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        return section
    }))
    
    
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .green
        title = album.name
        // Do any additional setup after loading the view.
        setupUI()
        serverData()
    }
    
    private func serverData(){
        ApiCaller.shared.getAlbumDetails(from: album) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    print(model)
                    self.viewModel = model.tracks.items?.compactMap({
                        RecommandViewModel(name: $0.name ?? "", artWorkURL: URL(string: self.album.images?.first?.url ?? ""), artistName: $0.artists?.first?.name ?? "")
                    }) ?? []
                    self.collectionView.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func setupUI(){
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.fitToSuper()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RecommandCollectionViewCell.self, forCellWithReuseIdentifier: RecommandCollectionViewCell.indetifer)
        collectionView.register(PlaylistHeaderCollectionViewReuseCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaylistHeaderCollectionViewReuseCell.identifier )
    }

}

extension NewReleasePlayListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommandCollectionViewCell.indetifer, for: indexPath) as! RecommandCollectionViewCell
        cell.configureCell(viewModel: viewModel[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PlaylistHeaderCollectionViewReuseCell.identifier, for: indexPath)
                as? PlaylistHeaderCollectionViewReuseCell,
              kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionViewCell()
      
          
        }
//
        let headerViewModel = PlaylistHeaderViewModel(name: album.name, ownName: album.artists?.first?.name, description: "", artworkURL: URL(string: album.images?.first?.url ?? ""))

        header.delegate = self
        header.configureCell(with: headerViewModel)
        
        return header
    }
}

extension NewReleasePlayListVC : PlaylistHeaderCollectionReusableViewDelegate {
    func playlistHeaderCollectionReuseableDidTapPlayAll(_ header: PlaylistHeaderCollectionViewReuseCell) {
        print("play all...")
    }
    
    
}
