//
//  PhotosServiceFake.swift
//  GalleryAppTests
//
//  Created by Jalal Najafi on 05/02/2021.
//

import Foundation

@testable
import GalleryApp

class PhotosServiceFake: PhotosServiceProtocol {
    private var result:Result<ResultModel, Error>
    private var resultURL:Result<[PhotoURLResultModel], Error>

    init(result:Result<ResultModel, Error>,resultURL:Result<[PhotoURLResultModel], Error>) {
        self.result = result
        self.resultURL = resultURL
    }
    
    func searchPhoto(name: String, page: Int, then handler: @escaping (Result<ResultModel, Error>) -> Void) {
        handler(result)
    }
    
    func getPhotoURL(photoIDs: [String], then handler: @escaping (Result<[PhotoURLResultModel], Error>) -> Void) {
        handler(resultURL)
    }
    
    func configure(result:Result<ResultModel, Error>){
        self.result = result
    }
    
    func configure(resultURL:Result<[PhotoURLResultModel], Error>){
        self.resultURL = resultURL
    }

}
