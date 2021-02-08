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
                viewController?.displayPhotos(result: .content(transformation(result: result)))
            }
        case .failure(let error):
            viewController?.displayPhotos(result: .error(error))
        }
    }

    private func transformation(result: [PhotoURLResultModel]) -> [PhotoViewModel]{
        var photos: [PhotoViewModel] = []
        result.forEach { photo in
            if let size = photo.size {
                let detailPhoto = size.first(where: {
                    $0.label == ImageSize.large.rawValue
                })?.source
                let listPhoto = size.first(where: {
                    $0.label == ImageSize.largeSquare.rawValue
                })?.source
                
                if let listPhotoUrl = URL(string: listPhoto ?? "") {
                    let photoViewModel = PhotoViewModel(detailUrl: URL(string: detailPhoto ?? ""), listUrl: listPhotoUrl)
                    photos.append(photoViewModel)
                }
            }
        }
        return photos
    }
    
}
