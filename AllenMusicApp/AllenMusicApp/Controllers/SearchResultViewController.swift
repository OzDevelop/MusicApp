//
//  SearchResultViewController.swift
//  AllenMusicApp
//
//  Created by 변상필 on 12/6/23.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        return collectionView
    }()
    
    let flowLayout = UICollectionViewFlowLayout()
    
    let networkManager = NetworkManager.shared
    
    var musics: [Music] = []
    
    var searchTerm: String? {
        didSet {
            setupDatas()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupCollectionView()
        collectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
    }
    
    func setupCollectionView() {
        
        view.addSubview(collectionView)
    
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        // 컬렉션뷰의 스크롤 방향 설정
        flowLayout.scrollDirection = .vertical
        
        let collectionCellWidth = (UIScreen.main.bounds.width - 1 * (3 - 1)) / 3
        
        flowLayout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellWidth)
        // 아이템 사이 간격 설정
        flowLayout.minimumInteritemSpacing = 1
        // 아이템 위아래 사이 간격 설정
        flowLayout.minimumLineSpacing = 1
        
        // 컬렉션뷰의 속성에 할당
        collectionView.collectionViewLayout = flowLayout
        
    }
    

    func setupDatas() {
        
        guard let term = searchTerm else { return }
        print("네트워킹 시작 단어 \(term)")
        
        // (네트워킹 시작전에) 다시 빈배열로 만들기
        self.musics = []
        
        networkManager.fetchMusic(searchTerm: "kpop") { result in
            print(#function)
            switch result {
            case .success(let musicDatas):
                self.musics = musicDatas
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchResultViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return musics.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell" , for: indexPath) as! MusicCollectionViewCell
        
        cell.imageUrl = musics[indexPath.row].imageUrl
        
        return cell
        
    }
    
    
}
