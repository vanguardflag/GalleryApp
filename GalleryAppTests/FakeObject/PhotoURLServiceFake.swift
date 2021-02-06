//
//  PhotoURLServiceFake.swift
//  GalleryAppTests
//
//  Created by Jalal Najafi on 05/02/2021.
//

import Foundation

@testable
import GalleryApp

class PhotoURLServiceFake: PhotoURLServiceProtocol {
    private var result:Result<[PhotoURLResultModel], Error>
    
    init(result:Result<[PhotoURLResultModel], Error>) {
        self.result = result
    }
    func getPhotoURL(photoIDs: [String], then handler: @escaping (Result<[PhotoURLResultModel], Error>) -> Void) {
        handler(result)
    }
    
    
    func configure(result:Result<[PhotoURLResultModel], Error>){
        self.result = result
    }
}
