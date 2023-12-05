//
//  MainView.swift
//  AllenMusicApp
//
//  Created by 변상필 on 12/5/23.
//

import UIKit

class MainView: UIView {
    
    
    //MARK: - 네비게이션 바

    let label: UILabel = {
        let label = UILabel()
        label.text = "text 제발 나와라예"
        label.backgroundColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout() {
        
        [label].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
