//
//  Constants.swift
//  AllenMusicApp
//
//  Created by 변상필 on 12/5/23.
//

import Foundation

//MARK: - NameSpace 구성

public enum MusicApi {
    static let requestUrl = "https://itunes.apple.com/search?"
    static let mediaParam = "media=music"
}

public struct Cell {
    static let musicCellIdentifier = "MusicCell"
    static let musicCollectionViewCellIdentifier = "CollectionViewCell"
    
    private init() {}
}

public struct CVCell {
    static let spacingWitdh: CGFloat = 1
    static let cellColumns: CGFloat = 3
    private init() {}
}
