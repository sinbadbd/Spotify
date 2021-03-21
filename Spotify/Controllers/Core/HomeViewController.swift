//
//  ViewController.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import UIKit


enum BrowserSlection {
    case newRelease(viewModel: [NewReleaseCellViewModel])
    case featurePlayList(viewModel: [NewReleaseCellViewModel])
    case recommandationTrack(viewModel: [NewReleaseCellViewModel])
}



class HomeViewController: UIViewController {
    
    //MARK: UI LAYOUT
    private var collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ -> NSCollectionLayoutSection? in
        return HomeViewController.createSectionLayout(section: sectionIndex)
    }))
    
    
    private var sections = [BrowserSlection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navHeader()
        getServerData()
        
        configureCollectionView()
    }
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.fitToSuper()
        //        collectionView.position(top: view.topAnchor, left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, insets: .init())
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(NewReleaseCollectionViewCell.self, forCellWithReuseIdentifier: NewReleaseCollectionViewCell.indetifer)
        
        collectionView.register(FeatureCollectionViewCell.self, forCellWithReuseIdentifier: FeatureCollectionViewCell.indetifer)
        
        collectionView.register(RecommandCollectionViewCell.self, forCellWithReuseIdentifier:  RecommandCollectionViewCell.indetifer)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
    }
    
    private static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
        
        switch section {
        case 0:
            //MARK: ITEM
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            
            //MARK: PADDING
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            //MARK: VERTICLE GROUP
            let VerticleGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(360)), subitem: item, count: 3)
            
            //MARK: HORIZONTAL GROUP
            let HorizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(360)), subitem: VerticleGroup, count: 1)
            
            //MARK: SECTION
            let section = NSCollectionLayoutSection(group: HorizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
            
            
            
        case 1:
            
            //MARK: ITEM
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(150)))
            
            //MARK: PADDING
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            //MARK: VERTICLE GROUP
            let VerticleGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(250)), subitem: item, count: 2)
            VerticleGroup.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 2, bottom: 20, trailing: 10)
            //MARK: HORIZONTAL GROUP
            let HorizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(250)), subitem: VerticleGroup, count: 1)
            
            //MARK: SECTION
            let section = NSCollectionLayoutSection(group: HorizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            return section
        case 2:
            //MARK: ITEM
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            
            //MARK: PADDING
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            //MARK: VERTICLE GROUP
            let VerticleGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(360)), subitem: item, count: 3)
            
            //MARK: HORIZONTAL GROUP
            let HorizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(360)), subitem: VerticleGroup, count: 1)
            
            //MARK: SECTION
            let section = NSCollectionLayoutSection(group: HorizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        default:
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
            
            //MARK: PADDING
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            //MARK: VERTICLE GROUP
            let VerticleGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(360)), subitem: item, count: 1)
            
            //MARK: HORIZONTAL GROUP
            let HorizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(360)), subitem: VerticleGroup, count: 1)
            
            //MARK: SECTION
            let section = NSCollectionLayoutSection(group: HorizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
            
        }
        
    }
    
    func navHeader(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .done, target: self, action: #selector(didTapSettings))
    }
    
    private func getServerData(){
        
        
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        
        var newReleaseRes : NewReleasesResponse?
        var featureRes : FeaturePlaylistResponse?
        var recommandRes: RecommandationResonse?
        
        //MARK: NEW RELEASE
        ApiCaller.shared.getAllNewReleases { result in
            
            defer {
                group.leave()
            }
            
            switch result {
            case .success(let model):
                newReleaseRes = model
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
        
        //MARK: Feature list
        ApiCaller.shared.GetAllFeaturedPlaylists { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let model):
                featureRes = model
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
        
        
        
        //MARK: Recommandation list
        ApiCaller.shared.GetRecommandationGenres {[self] result in
            defer {
                group.leave()
            }
            
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
                        defer {
                            group.leave()
                        }
                        
                        switch result {
                        case .success(let model):
                            recommandRes = model
                            break
                        case .failure(let error):
                            print(error.localizedDescription)
                            break
                        }
                        
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            // Configuration viewmodel
        }
        
        group.notify(queue: .main) {
            guard
                let newAlbum = newReleaseRes?.albums,
                let feture = featureRes?.playlists,
                let recomnd = recommandRes?.tracks
            else {
                return
            }
        }
    }
    
    func configurationViewModel(newAlbums:[Ablum],feture:[PlayList], recomnd:[AudioTrack]){
        
//        sections.append(BrowserSlection.newRelease(viewModel: newAlbums.compactMap({
//            return NewReleaseCellViewModel(name: $0.name ?? "", artWorkURL: $0.images?.first?.url, numberOfTracks: <#T##Int#>, artistName: <#T##String#>)
//        })))
        sections.append(BrowserSlection.featurePlayList(viewModel: []))
        sections.append(BrowserSlection.recommandationTrack(viewModel: []))
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
        return 20
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.backgroundColor = .systemBlue
        }else if indexPath.section == 1 {
            cell.backgroundColor = .red
        }else if indexPath.section == 2 {
            cell.backgroundColor = .green
        }
        
        return cell
    }
    
    
}
