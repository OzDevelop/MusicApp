//
//  TableViewCell.swift
//  AllenMusicApp
//
//  Created by 변상필 on 12/5/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //MARK: - 하위 뷰
    let mainImageView: UIImageView = {
       let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let songNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 5
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    var imageUrl: String? {
        didSet {
            
        }
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupStackView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStackView() {
        self.contentView.addSubview(mainImageView)
        self.contentView.addSubview(stackView)
        
        [songNameLabel, artistNameLabel, albumNameLabel, releaseDateLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func setLayout() {
        setImageViewLayout()
        setStackViewLayout()
    }
    
    func setImageViewLayout() {
        NSLayoutConstraint.activate([
            mainImageView.heightAnchor.constraint(equalToConstant: 100),
            mainImageView.widthAnchor.constraint(equalToConstant: 100),
            mainImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            mainImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            mainImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    
    func setStackViewLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
        ])
    }
    
    
    
    
    // 얘네는 뭐하는 애들인지 알아보자
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
