//
//  PhotosGalleryPresenter.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 04/02/2021.
//

import Foundation



protocol PhotosGalleryPresentationLogic {
    func displayPhotos(with presentResult: FetchPhoto.Response)
}

public final class PhotosGalleryPresenter: PhotosGalleryPresentationLogic {
    weak var viewController: PhotoGalleryDisplayLogic?

    func displayPhotos(with presentResult: FetchPhoto.Response) {
        switch presentResult.result {
        case .success(let result):
            if result.isEmpty{
                viewController?.displayPhotos(result: .empty)
            }else{
                viewController?.displayPhotos(result: .content(result))
            }
        case .failure(let error):
            viewController?.displayPhotos(result: .error(error))
        }
    }

    
}
