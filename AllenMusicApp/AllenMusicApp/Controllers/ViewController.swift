//
//  ViewController.swift
//  AllenMusicApp
//
//  Created by 변상필 on 12/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var mainView = MainView()
    var music: [Music] = Music.dummyArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = mainView
        
        navigationItem.title = "Music Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
    }
    
    func setupTableView() {
        mainView.tableView.dataSource = self
        mainView.tableView.register(TableViewCell.self, forCellReuseIdentifier: "MusicCell")
    }
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return music.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(#function)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! TableViewCell
        
        cell.imageUrl = music[indexPath.row].imageUrl
        cell.albumNameLabel.text = music[indexPath.row].albumName
        cell.artistNameLabel.text = music[indexPath.row].artistName
        cell.releaseDateLabel.text = music[indexPath.row].releaseDateString
        cell.songNameLabel.text = music[indexPath.row].songName
        
        return cell
    }
}

