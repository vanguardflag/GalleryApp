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
    
    override func setUpWithError() throws {
        fakePhotoService = PhotosServiceFake(result: .success(ResultModel.init()),resultURL: .success([]))
        fakePresenter = PhotoGalleryPresenterMock()
        sut = PhotosGalleryInteractor(presenter: fakePresenter,
                                      service: fakePhotoService)
    }


    func testGetPhotosProblem() {
        
        sut.getPhotos(textSearch: "", isloadingMore: false)
        XCTAssert(fakePresenter.hasCallDisplayPhotos)
    }

 
    func testGetPhotoWithData(){
        let sutData: ResultModel = bundle.decodeFile(name: "photolist")!
        fakePhotoService.configure(result: .success(sutData))
    
        sut.getPhotos(textSearch: "", isloadingMore: false)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            XCTAssert(self.fakePresenter.hasCallDisplayPhotos)
        }
        
    }
    
    
    func testGetPhotoWithError(){
        fakePhotoService.configure(result: .failure(AppError.noData))
    
        sut.getPhotos(textSearch: "", isloadingMore: false)
        
        XCTAssert(fakePresenter.hasCallDisplayPhotos)
        
    }
    func testGetPhotoWithEmpty(){
        let sutData: ResultModel = bundle.decodeFile(name: "photolistempty")!
        fakePhotoService.configure(result: .success(sutData))
    
        sut.getPhotos(textSearch: "", isloadingMore: false)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            XCTAssert(self.fakePresenter.hasCallDisplayPhotos)
        }
            
    }
    
    func testCanFetchData(){
        let sutData: ResultModel = bundle.decodeFile(name: "photolist")!
        fakePhotoService.configure(result: .success(sutData))
    
        sut.getPhotos(textSearch: "", isloadingMore: false)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            XCTAssert(self.fakePresenter.hasCallDisplayPhotos)
        }
        
        XCTAssertTrue(sut.canFetchMorePhotos == true)
        
    }
    
    func testCanNotFetchData(){
        let sutData: ResultModel = bundle.decodeFile(name: "photolistlastpage")!
        fakePhotoService.configure(result: .success(sutData))
    
        sut.getPhotos(textSearch: "", isloadingMore: false)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            XCTAssert(self.fakePresenter.hasCallDisplayPhotos)
        }
        
        XCTAssertTrue(sut.canFetchMorePhotos == false)
        
    }

 
}
