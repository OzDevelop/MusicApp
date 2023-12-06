//
//  ViewController.swift
//  AllenMusicApp
//
//  Created by 변상필 on 12/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var mainView = MainView()
    
    var networkManager: NetworkManager = NetworkManager.shared
    var musics: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = mainView
        
        navigationItem.title = "Music Search"
        navigationItem.searchController = mainView.searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
        setupDatas()
        setupsearchController()
    }
    
    func setupTableView() {
        mainView.tableView.dataSource = self
        mainView.tableView.register(TableViewCell.self, forCellReuseIdentifier: "MusicCell")
    }
    
    func setupsearchController() {
        mainView.searchController.searchResultsUpdater = self
    }
    
    func setupDatas() {
        networkManager.fetchMusic(searchTerm: "jazz") { result in
            print(#function)
            switch result {
            case .success(let musicDatas):
                self.musics = musicDatas
                DispatchQueue.main.async {
                    self.mainView.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return musics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath) as! TableViewCell
        
        cell.imageUrl = musics[indexPath.row].imageUrl
        cell.albumNameLabel.text = musics[indexPath.row].albumName
        cell.artistNameLabel.text = musics[indexPath.row].artistName
        cell.releaseDateLabel.text = musics[indexPath.row].releaseDateString
        cell.songNameLabel.text = musics[indexPath.row].songName
        
        return cell
    }
}

extension ViewController: UISearchResultsUpdating {
    // 유저가 글자를 입력하는 순간마다 호출되는 메서드 ===> 일반적으로 다른 화면을 보여줄때 구현
    func updateSearchResults(for searchController: UISearchController) {
        print(#function)
        print("서치바에 입력되는 단어", searchController.searchBar.text ?? "")
        // 글자를 치는 순간에 다른 화면을 보여주고 싶다면 (컬렉션뷰를 보여줌)
        let vc = searchController.searchResultsController as! SearchResultViewController
        // 컬렉션뷰에 찾으려는 단어 전달
        vc.searchTerm = searchController.searchBar.text ?? ""
    }
}
