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
    }
    
    func setupTableView() {
        mainView.tableView.dataSource = self
        mainView.tableView.register(TableViewCell.self, forCellReuseIdentifier: "MusicCell")
    }
    
    func setupDatas() {
        networkManager.fetchMusic(searchTerm: "kpop") { result in
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
        print(#function)
        return musics.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(#function)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! TableViewCell
        
        cell.imageUrl = musics[indexPath.row].imageUrl
        cell.albumNameLabel.text = musics[indexPath.row].albumName
        cell.artistNameLabel.text = musics[indexPath.row].artistName
        cell.releaseDateLabel.text = musics[indexPath.row].releaseDateString
        cell.songNameLabel.text = musics[indexPath.row].songName
        
        return cell
    }
}

