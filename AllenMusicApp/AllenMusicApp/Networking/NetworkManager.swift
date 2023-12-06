//
//  NetworkManager.swift
//  AllenMusicApp
//
//  Created by 변상필 on 12/5/23.
//

import Foundation

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

//MARK: - Networking 클래스 모델

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
        
    typealias NetworkCompletion = (Result<[Music], NetworkError>) -> Void
    
    func fetchMusic(searchTerm: String, completion: @escaping NetworkCompletion) {
        let urlString = "\(MusicApi.requestUrl)\(MusicApi.mediaParam)&term=\(searchTerm)"
         
        performRequest(with: urlString) { result in
            completion(result)
        }
    }
    
    private func performRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            if let musics = self.parseJson(safeData) {
                completion(.success(musics))
            } else {
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    private func parseJson(_ musicData: Data) -> [Music]? {
        
        do {
            let musicData = try JSONDecoder().decode(MusicData.self, from: musicData)
            return musicData.results
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

