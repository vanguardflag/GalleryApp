//
//  PhotoeGalleryService.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 04/02/2021.
//

import Foundation

protocol PhotosServiceProtocol {
    func searchPhoto(name:String,page:Int,then handler: @escaping (Result<ResultModel, Error>) -> Void)
}

class PhotosService {
    // MARK: - Properties
    private var currentTask: URLSessionTask?
    
    // MARK: - Private BuildURL
    private func buildURL(for page: Int,
                          search: String?) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = APIConstant.scheme
        urlComponents.host = APIConstant.host
        urlComponents.path = APIConstant.path
        
        let methodQueryItem = URLQueryItem(name: APIConstant.methodKey,
                                           value: "\(method.searchPhoto.rawValue)")
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
}


extension PhotosService: PhotosServiceProtocol {
    
    func searchPhoto(name: String, page: Int,then handler: @escaping (Result<ResultModel, Error>) -> Void) {
        guard let url = buildURL(for: page, search: name) else {
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
    
}

