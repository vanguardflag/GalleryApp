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
    let photoURLService:PhotoURLServiceProtocol
    private var currentPage: Int = 1
    private var pageSize: Int = 0
    private var totalpage: Int = 0
    private var textSearch: String = ""
    
    init(presenter: PhotosGalleryPresentationLogic,
         service: PhotosServiceProtocol = PhotosService(),
         photoURLService:PhotoURLServiceProtocol = PhotoURLService()) {
        self.service = service
        self.photoURLService = photoURLService
        self.presenter = presenter
    }
    
    
    
    //MARK: Logic
    var canFetchMorePhotos: Bool{
        if currentPage > totalpage {
            return false
        }else {
            return true
        }
    }

    
    func getPhotos(textSearch:String = "", isloadingMore:Bool = false) {
        if isloadingMore{
            loadPhotos(textSearch: self.textSearch)
        }else{
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
            case .failure(let error):
                self?.presenter.displayPhotos(with: .init(result: .failure(.loadingFailed)))
                
            }
        }
    }
    
    
    private func getPhotoUrl(photoList: [PhotosModel]){
        
        let current = photoList.map { return $0.id ?? "" }
        photoURLService.getPhotoURL(photoIDs: current){[weak self] result in
            switch result{
            case .success(let response):
                self?.presenter.displayPhotos(with: .init(result: .success(response)))
            case .failure(_):
                self?.presenter.displayPhotos(with: .init(result: .failure(.loadingFailed)))
            }
        }
    }
    
}
