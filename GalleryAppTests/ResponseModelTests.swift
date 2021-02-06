//
//  ResponseModelTests.swift
//  GalleryAppTests
//
//  Created by Jalal Najafi on 06/02/2021.
//

import XCTest
@testable
import GalleryApp

class ResponseModelTests: XCTestCase {
    private let bundle = Bundle(for: ResponseModelTests.self)
    
    override func setUpWithError() throws {
    }

    func testPhotolistResponse() {
        let jsonFileName = "photolist"
        
        let sut: ResultModel = bundle.decodeFile(name: jsonFileName)!
        
        XCTAssertTrue(sut.photos?.page == 1)
        XCTAssertTrue(sut.photos?.perpage == 100)
        XCTAssertTrue(sut.photos?.pages == 10)
        XCTAssertTrue(sut.photos?.photo?.count == 100)
    }
    
    func testPhotolistEmpty() {
        let jsonFileName = "photolistempty"
        
        let sut: ResultModel = bundle.decodeFile(name: jsonFileName)!
        
        XCTAssert(sut.photos?.photo?.count == 0)
    }
    
    
    func testPhotolistResponseLastPage() {
        let jsonFileName = "photolistlastpage"

        let sut: ResultModel = bundle.decodeFile(name: jsonFileName)!

        XCTAssertTrue(sut.photos?.page == 9139)
        XCTAssertTrue(sut.photos?.perpage == 80)
        XCTAssertTrue(sut.photos?.pages == 9139)
    }

    
    func testPhotoURLResponse() {
        let jsonFileName = "photoSize"

        let sut: PhotoURLResult = bundle.decodeFile(name: jsonFileName)!
        
        XCTAssertNotNil(sut.sizes?.size)
        XCTAssertNotNil(sut.sizes?.size?.first(where: { $0.label == ImageSize.largeSquare.rawValue
        }))
        XCTAssertNotNil(sut.sizes?.size?.first(where: { $0.label == ImageSize.largeSquare.rawValue
        })?.source)
        
    }
    
    

    
}
