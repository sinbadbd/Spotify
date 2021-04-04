//
//  FeaturePlayListVC.swift
//  Spotify
//
//  Created by Imran on 24/3/21.
//

import UIKit

class FeaturePlayListVC: UIViewController {
    
    private var playList : PlayList
    
    private var viewModel = [RecommandViewModel]()
    private var tracks = [AudioTrack]()
    
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
    
    init(playList: PlayList) {
        self.playList = playList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = playList.name
        view.backgroundColor = .brown
        
        setupUI()
        serverData()
        
//        navigationController.hideTransparentNavigationBar()
    }
//    override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//            navigationController?.setNavigationBarHidden(true, animated: animated)
//        }
//        
//        override func viewWillDisappear(_ animated: Bool) {
//            super.viewWillDisappear(animated)
//            navigationController?.setNavigationBarHidden(false, animated: animated)
//        }
    
    private func setupUI(){
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.fitToSuper()
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(RecommandCollectionViewCell.self, forCellWithReuseIdentifier: RecommandCollectionViewCell.indetifer)
        collectionView.register(PlaylistHeaderCollectionViewReuseCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaylistHeaderCollectionViewReuseCell.identifier )
    }
    
    private func serverData(){
        ApiCaller.shared.getPlayListDetails(from: playList) {[weak self] result in
            print("Result=\(result)")
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    
                    self?.viewModel = model.tracks.items.compactMap({
                        RecommandViewModel(name: $0.track.name, artWorkURL: URL(string: $0.track.album?.images?.first?.url ?? ""), artistName: $0.track.artists.first?.name ?? "")
                    })
                    self?.collectionView.reloadData()
                    print(model)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension FeaturePlayListVC: UICollectionViewDataSource, UICollectionViewDelegate {
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
        
        let headerViewModel = PlaylistHeaderViewModel(name: playList.name, ownName: playList.itemDescription, description: playList.itemDescription, artworkURL: URL(string: playList.images.first?.url ?? ""))
        
        header.delegate = self
        header.configureCell(with: headerViewModel)
        
        return header
    }
}

extension FeaturePlayListVC : PlaylistHeaderCollectionReusableViewDelegate {
    func playlistHeaderCollectionReuseableDidTapPlayAll(_ header: PlaylistHeaderCollectionViewReuseCell) {
        print("play all...")
    }
    
    
}
