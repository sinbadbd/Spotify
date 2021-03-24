//
//  ViewController.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import UIKit


enum BrowserSlection {
    case newRelease(viewModel: [NewReleaseCellViewModel])
    case featurePlayList(viewModel: [FeaturedPlayListModelView])
    case recommandationTrack(viewModel: [RecommandViewModel])
}



class HomeViewController: UIViewController {
    
    private var newAlbumList: [Ablum] = []
    private var featuredList : [PlayList] = []
    private var recommandation : [AudioTrack] = []
    
    
    //MARK: UI LAYOUT
    private var collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ -> NSCollectionLayoutSection? in
        return HomeViewController.createSectionLayout(section: sectionIndex)
    }))
    
    
    private var sections = [BrowserSlection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        navHeader()
        
        
        configureCollectionView()
        //        getServerData()
        
        fetchData()
        // getAllData()
    }
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.fitToSuper()
        
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(NewReleaseCollectionViewCell.self, forCellWithReuseIdentifier: NewReleaseCollectionViewCell.indetifer)
        
        collectionView.register(FeatureCollectionViewCell.self, forCellWithReuseIdentifier: FeatureCollectionViewCell.indetifer)
        
        collectionView.register(RecommandCollectionViewCell.self, forCellWithReuseIdentifier:  RecommandCollectionViewCell.indetifer)
        //
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        
    }
 
    
    func navHeader(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .done, target: self, action: #selector(didTapSettings))
    }
    
     
    
    private func fetchData() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        var newReleases: NewReleasesResponse?
        var featuredPlaylist: FeaturePlaylistResponse?
        var recommendations: RecommandationResonse?
        
        // New Releases
        ApiCaller.shared.getAllNewReleases { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                newReleases = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        // Featured Playlists
        ApiCaller.shared.GetAllFeaturedPlaylists { result in
            defer {
                group.leave()
            }
            
            switch result {
            case .success(let model):
                featuredPlaylist = model
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        
        // Recommended Tracks
        ApiCaller.shared.GetRecommandationGenres { result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                
                ApiCaller.shared.GetRecommendations(geners: seeds) { recommendedResult in
                    defer {
                        group.leave()
                    }
                    
                    switch recommendedResult {
                    case .success(let model):
                        recommendations = model
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        group.notify(queue: .main) {
            guard let newAlbums = newReleases?.albums.items,
                  let playlists = featuredPlaylist?.playlists.items,
                  let tracks = recommendations?.tracks else {
                fatalError("Models are nil")
            }
            self.configurModel(newAlbumList: newAlbums, featuredList: playlists, recommandation: tracks)
        }
    }

    
    public func configurModel(newAlbumList:[Ablum], featuredList:[PlayList], recommandation:[AudioTrack]){
        
        self.newAlbumList = newAlbumList
        self.featuredList = featuredList
        self.recommandation = recommandation
        
        
        sections.append(.newRelease(viewModel: newAlbumList.compactMap({
            return NewReleaseCellViewModel(name: $0.name ?? "", artWorkURL: URL(string: $0.images?.first?.url ?? ""), numberOfTracks: $0.totalTracks ?? 0, artistName: $0.artists?.first?.name ?? "")
        }) ))
        
        sections.append(.featurePlayList(viewModel: featuredList.compactMap({
            return FeaturedPlayListModelView(name: $0.name)
        }) ))
        
        
        sections.append(.recommandationTrack(viewModel: recommandation.compactMap({
            return RecommandViewModel(name: $0.name, artWorkURL: URL(string: $0.album.images?.first?.url ?? ""), artistName: $0.name)
        }) ))
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        
    }
    
    @objc func didTapSettings(){
        let vc = SettingsViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        
        switch type {
        case .newRelease(let viewModel):
            //            print("viewModel.count:\(viewModel.count)")
            return viewModel.count
        case .featurePlayList(let viewModel):
            return viewModel.count
        case .recommandationTrack(let viewModel):
            return viewModel.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print(sections.count)
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let section = sections[indexPath.section]
        
        switch section {
        case .newRelease:
            
            let album = newAlbumList[indexPath.item]
            
            let vc = NewReleasePlayListVC(album: album)
            vc.title = album.name
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
             
        case .featurePlayList:
            
            let playlist = featuredList[indexPath.item]
            let vc = FeaturePlayListVC(playList: playlist)
            vc.title = playlist.name
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            
        case .recommandationTrack:
            
            let recomand = recommandation[indexPath.item]
            let vc = RecommandationPlayListVC(audioTrack: recomand)
            vc.title = recomand.name
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        switch type {
        case .newRelease(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewReleaseCollectionViewCell.indetifer,
                for: indexPath
            ) as? NewReleaseCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .cyan
            let viewModel = viewModels[indexPath.row]
            cell.configureCell(viewModel: viewModel)
            return cell
        case .featurePlayList(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FeatureCollectionViewCell.indetifer,
                for: indexPath
            ) as? FeatureCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.backgroundColor = .magenta
            cell.configureCell(viewModel: viewModel)
            return cell
        case .recommandationTrack(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecommandCollectionViewCell.indetifer,
                for: indexPath
            ) as? RecommandCollectionViewCell else {
                return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.backgroundColor = .orange
            cell.configureCell(viewModel: viewModel)
            return cell
        }
    }

    static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        
        switch section {
        case 0:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(0.1)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            // Vertical group in horizontal group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(300)
                ),
                subitem: item,
                count: 3
            )
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(390)
                ),
                subitem: verticalGroup,
                count: 1
            )
            
            // Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        case 1:
            // Item
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(150),
                    heightDimension: .absolute(350)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 20)
            
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(150),
                    heightDimension: .absolute(350)
                ),
                subitem: item,
                count: 2
            )
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(150),
                    heightDimension: .absolute(350)
                ),
                subitem: verticalGroup,
                count: 1
            )
//            horizontalGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 20)
            
            // Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        case 2:
            // Item
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
            return section
        default:
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(100)
                ),
                subitem: item,
                count: 1
            )
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    
    }
}
