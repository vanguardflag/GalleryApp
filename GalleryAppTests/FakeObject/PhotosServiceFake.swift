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
    init(result:Result<ResultModel, Error>) {
        self.result = result
    }
    
    func searchPhoto(name: String, page: Int, then handler: @escaping (Result<ResultModel, Error>) -> Void) {
        handler(result)
    }
    
    
    func configure(result:Result<ResultModel, Error>){
        self.result = result
    }

}
