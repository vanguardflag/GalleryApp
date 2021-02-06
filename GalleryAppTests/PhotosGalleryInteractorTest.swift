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
    private let bundle = Bundle(for: ResponseModelTests.self)
    private var sut:PhotosGalleryInteractor!
    private var fakePresenter:PhotoGalleryPresenterMock!
    private var fakePhotoService:PhotosServiceFake!
    private var fakePhotoURL:PhotoURLServiceFake!
    
    override func setUpWithError() throws {
        fakePhotoService = PhotosServiceFake(result: .success(ResultModel.init()))
        fakePhotoURL = PhotoURLServiceFake(result: .success([]))
        fakePresenter = PhotoGalleryPresenterMock()
        sut = PhotosGalleryInteractor(presenter: fakePresenter,
                                      service: fakePhotoService,
                                      photoURLService: fakePhotoURL)
    }


    func testGetPhotosProblem() {
        
        sut.getPhotos(textSearch: "", isloadingMore: false)
        XCTAssert(fakePresenter.hasCallDisplayPhotos)
    }

 
    func testGetPhotoWithData(){
        let sutData: ResultModel = bundle.decodeFile(name: "photolist")!
        fakePhotoService.configure(result: .success(sutData))
    
        sut.getPhotos(textSearch: "", isloadingMore: false)
        
        XCTAssert(fakePresenter.hasCallDisplayPhotos)
        
    }
    
    
    func testGetPhotoWithError(){
        fakePhotoService.configure(result: .failure(AppError.noData))
    
        sut.getPhotos(textSearch: "", isloadingMore: false)
        
        XCTAssert(fakePresenter.hasCallDisplayPhotos)
        
    }
    
    

}
