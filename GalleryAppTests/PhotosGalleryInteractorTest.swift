//
//  PhotosGalleryInteractorTest.swift
//  GalleryAppTests
//
//  Created by Jalal Najafi on 05/02/2021.
//

import XCTest

@testable
import GalleryApp

class PhotosGalleryInteractorTest: XCTestCase {
    
    var sut:PhotosGalleryInteractor!
    var fakePresenter:PhotoGalleryPresenterMock!
    var fakePhotoService:PhotosServiceFake!
    var fakePhotoURL:PhotoURLServiceFake!
    
    override func setUpWithError() throws {
        fakePhotoService = PhotosServiceFake(result: .success(ResultModel.init()))
        fakePhotoURL = PhotoURLServiceFake(result: .success([]))
        fakePresenter = PhotoGalleryPresenterMock()
        sut = PhotosGalleryInteractor(presenter: fakePresenter,
                                      service: fakePhotoService,
                                      photoURLService: fakePhotoURL)
    }


    func testGetPhotos() {
        
        sut.getPhotos(textSearch: "", isloadingMore: false)
        XCTAssert(fakePresenter.hasCallDisplayPhotos)
    }

 
    
    

}
