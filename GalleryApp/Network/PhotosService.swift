//
//  PhotoeGalleryService.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 04/02/2021.
//

import Foundation

protocol PhotosServiceProtocol {
    func searchPhoto(name: String, page: Int,then handler: @escaping (Result<ResultModel, Error>) -> Void)
    func getPhotoURL(photoIDs: [String], then handler: @escaping (Result<[PhotoURLResultModel], Error>) -> Void)
}

class PhotosService {
    // MARK: - Properties
    private var currentTask: URLSessionTask?
    private var result: [PhotoURLResultModel] = []
    
    private enum EndPoint {
        case search(page: Int, search: String?)
        case getSize(photoID: String)
    }
    

    // MARK: - Private BuildURL
    private func buildURL(endPoint: EndPoint)->URL?{
        switch endPoint {
        case .getSize(let photoID):
            return buildURL(photoID: photoID)
        case .search(let page, let search):
            return buildURL(for: page, search: search)
        }
    }
    
    private func buildURL(for page: Int,
                          search: String?) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = APIConstant.scheme
        urlComponents.host = APIConstant.host
        urlComponents.path = APIConstant.path
        
        let methodQueryItem = URLQueryItem(name: APIConstant.methodKey,
                                           value: "\(Method.searchPhoto.rawValue)")
        var queryItems: [URLQueryItem] = [methodQueryItem]
        queryItems.append(URLQueryItem(name: APIConstant.apiKey,
                                       value: APIConstant.appAPIKey))
        queryItems.append(URLQueryItem(name: APIConstant.tags, value: search))
        queryItems.append(URLQueryItem(name: APIConstant.page, value: String(page)))
        queryItems.append(URLQueryItem(name: APIConstant.formatKey, value: APIConstant.jsonType))
        queryItems.append(URLQueryItem(name: APIConstant.nojsoncallbackKey, value: String(1)))
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
    private func buildURL(photoID: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = APIConstant.scheme
        urlComponents.host = APIConstant.host
        urlComponents.path = APIConstant.path
        let methodQueryItem = URLQueryItem(name: APIConstant.methodKey,
                                           value: "\(Method.getSize.rawValue)")
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


extension PhotosService: PhotosServiceProtocol {
    func searchPhoto(name: String, page: Int,then handler: @escaping (Result<ResultModel, Error>) -> Void) {
        guard let url = buildURL(endPoint: .search(page: page, search: name)) else {
            handler(.failure(AppError.requestError))
            return
        }
        if let currentTask = currentTask, currentTask.state == .running {
            currentTask.cancel()
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                handler(.failure(AppError.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ResultModel.self, from: data)
                handler(.success(response))
            } catch let error {
                handler(.failure(error))
                return
            }
        }
        currentTask = task
        task.resume()
    }
    
    func getPhotoURL(photoIDs: [String], then handler: @escaping (Result<[PhotoURLResultModel], Error>) -> Void) {
        let group = DispatchGroup()
        for photoID in photoIDs{
            group.enter()
            guard let url = buildURL(endPoint: .getSize(photoID: photoID)) else {
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
                } catch _ {
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

