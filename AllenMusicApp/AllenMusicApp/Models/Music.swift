//
//  Musci.swift
//  AllenMusicApp
//
//  Created by 변상필 on 12/5/23.
//

import Foundation

//MARK: - 데이터 모델

// 실제 API에서 받게 되는 정보

struct MusicData: Codable {
    let resultCount: Int
    let results: [Music]

}

// 실제 우리가 사용하게될 음악(Music) 모델 구조체
// (서버에서 가져온 데이터만 표시해주면 되기 때문에 일반적으로 구조체로 만듦)

struct Music: Codable {
    let songName: String?
    let artistName: String?
    let albumName: String?
    let previewUrl: String?
    let imageUrl: String?
    private let releaseDate: String?
    
    // 네트워크에서 주는 이름을 변환하는 방법 (원시값)
    // (서버: trackName ===> songName)
    enum CodingKeys: String, CodingKey {
        case songName = "trackName"
        case artistName
        case albumName = "collectionName"
        case previewUrl
        case imageUrl = "artworkUrl100"
        case releaseDate
    }
    
    // (출시 정보에 대한 날짜를 잘 계산하기 위해서) 계산 속성으로
    // "2011-07-05T12:00:00Z" ===> "yyyy-MM-dd"
    var releaseDateString: String? {
        // 서버에서 주는 형태 (ISO규약에 따른 문자열 형태)
        guard let isoDate = ISO8601DateFormatter().date(from: releaseDate ?? "") else {
            return ""
        }
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = myFormatter.string(from: isoDate)
        return dateString
    }
}



extension Music {
    // Music 모델의 더미 데이터 생성
    static var dummyData: Music {
        return Music(
            songName: "Sample Song",
            artistName: "Sample Artist",
            albumName: "Sample Album",
            previewUrl: "https://sample-preview-url.com",
            imageUrl: "https://sample-image-url.com",
            releaseDate: "2022-01-01T00:00:00Z"
        )
    }
    
    static var dummyArray: [Music] {
           return [
               Music(
                   songName: "Song 1",
                   artistName: "Artist 1",
                   albumName: "Album 1",
                   previewUrl: "https://preview-url-1.com",
                   imageUrl: "https://image-url-1.com",
                   releaseDate: "2022-02-01T00:00:00Z"
               ),
               Music(
                   songName: "Song 2",
                   artistName: "Artist 2",
                   albumName: "Album 2",
                   previewUrl: "https://preview-url-2.com",
                   imageUrl: "https://image-url-2.com",
                   releaseDate: "2022-03-01T00:00:00Z"
               ),
               // ... 추가적인 더미 데이터들을 필요에 따라 계속 추가할 수 있습니다.
           ]
       }
}
