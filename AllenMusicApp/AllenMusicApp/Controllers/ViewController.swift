//
//  ViewController.swift
//  AllenMusicApp
//
//  Created by 변상필 on 12/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var mainView = MainView()
    
    
    override func loadView() {
        view = mainView
        
        navigationItem.title = "Music Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

