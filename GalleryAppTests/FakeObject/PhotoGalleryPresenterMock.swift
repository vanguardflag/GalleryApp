//
//  PhotoGalleryPresenter.swift
//  GalleryAppTests
//
//  Created by Jalal Najafi on 05/02/2021.
//

import Foundation

@testable
import GalleryApp

class PhotoGalleryPresenterMock:PhotosGalleryPresentationLogic{
    private(set) var hasCallDisplayPhotos:Bool = false
    
    func displayPhotos(with presentResult: FetchPhoto.Response) {
        hasCallDisplayPhotos = true
    }
    
    
}
