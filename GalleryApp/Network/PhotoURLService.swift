//
//  PhotoSizeService.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 04/02/2021.
//

import Foundation

protocol PhotoURLServiceProtocol {
    func getPhotoURL(photoIDs:[String],then handler: @escaping (Result<[PhotoURLResultModel], Error>) -> Void)
}

class PhotoURLService {
    // MARK: - Properties
    private var currentTask: URLSessionTask?
    private var result: [PhotoURLResultModel] = []
    // MARK: - Private BuildURL
    private func buildURL(photoID:String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = APIConstant.scheme
        urlComponents.host = APIConstant.host
        urlComponents.path = APIConstant.path
        
        let methodQueryItem = URLQueryItem(name: APIConstant.methodKey,
                                           value: "\(method.getSize.rawValue)")
        var queryItems: [URLQueryItem] = [methodQueryItem]
        
        queryItems.append(URLQueryItem(name: APIConstant.apiKey,
                                       value: APIConstant.appAPIKey))
        queryItems.append(URLQueryItem(name: APIConstant.photoId, value: photoID))
        
        queryItems.append(URLQueryItem(name: APIConstant.formatKey, value: APIConstant.jsonType))
        queryItems.append(URLQueryItem(name: APIConstant.nojsoncallbackKey, value: String(1)))
        
        
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}

extension PhotoURLService: PhotoURLServiceProtocol {

    
    func getPhotoURL(photoIDs: [String],then handler: @escaping (Result<[PhotoURLResultModel], Error>) -> Void) {
        let group = DispatchGroup()
        
        for photoID in photoIDs{
            group.enter()
            guard let url = buildURL(photoID: photoID) else {
                group.leave()
                return
            }
            
            
            
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                
                
                guard let data = data else {
                    group.leave()
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(PhotoURLResult.self, from: data)
                    guard let urlSize = response.sizes else {
                        group.leave()
                        return
                    }
                    self.result.append(urlSize)
                    group.leave()
                } catch let error {
                    group.leave()
                    return
                }
            }
            
            currentTask = task
            task.resume()
        }
        
        
        group.notify(queue: .global()) {
            // All requests completed
            handler(.success(self.result))
            self.result.removeAll()
        }
    }
    
}



