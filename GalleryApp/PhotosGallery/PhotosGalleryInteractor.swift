//
//  PhotosGalleryInteractor.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 04/02/2021.
//

import Foundation

public protocol PhotoGalleryBussinesLogic:AnyObject{
    var canFetchMorePhotos: Bool { get }
    func getPhotos(textSearch:String,isloadingMore:Bool)
}


class PhotosGalleryInteractor: PhotoGalleryBussinesLogic {
    //MARK:  Properties
    let presenter: PhotosGalleryPresentationLogic
    let service: PhotosServiceProtocol
    private var currentPage: Int = 1
    private var pageSize: Int = 0
    private var totalpage: Int = 0
    private var textSearch: String = ""
    
    init(presenter: PhotosGalleryPresentationLogic,
         service: PhotosServiceProtocol = PhotosService()) {
        self.service = service
        self.presenter = presenter
    }
    
    
    
    //MARK: Logic
    var canFetchMorePhotos: Bool{
        return currentPage > totalpage
    }

    func getPhotos(textSearch:String = "", isloadingMore:Bool = false) {
        if isloadingMore{
            loadPhotos(textSearch: self.textSearch)
        } else {
            self.textSearch = textSearch
            currentPage = 1
            pageSize = 0
            totalpage = 0
            loadPhotos(textSearch: textSearch)
        }
    }
    
    private func loadPhotos(textSearch: String){
        self.service.searchPhoto(name: textSearch, page: currentPage) { [weak self] result in
            switch result {
            case .success(let response):
                guard let result = response.photos, let photos = result.photo else {
                    self?.presenter.displayPhotos(with: .init(result: .failure(.loadingFailed)))
                    return
                }
                self?.pageSize = result.perpage ?? 0
                self?.currentPage = (result.page ?? 0) + 1
                self?.totalpage = result.pages ?? 0
                self?.getPhotoUrl(photoList: photos)
            case .failure:
                self?.presenter.displayPhotos(with: .init(result: .failure(.loadingFailed)))
            }
        }
    }
    
    
    private func getPhotoUrl(photoList: [PhotoInfoModel]){
        let current = photoList.map { return $0.id ?? "" }
        service.getPhotoURL(photoIDs: current){[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.presenter.displayPhotos(with: .init(result: .success(response)))
                case .failure(_):
                    self?.presenter.displayPhotos(with: .init(result: .failure(.loadingFailed)))
                }
            }
        }
    }
    
}
