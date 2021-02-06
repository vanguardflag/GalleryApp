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
        // Given
        let jsonFileName = "photolist"
        
        // When
        let sut: ResultModel = bundle.decodeFile(name: jsonFileName)!
        
        // Then
        XCTAssertTrue(sut.photos?.page == 1)
        XCTAssertTrue(sut.photos?.perpage == 100)
        XCTAssertTrue(sut.photos?.pages == 10)
        XCTAssertTrue(sut.photos?.photo?.count == 100)
    }
    
    func testPhotolistEmpty() {
        // Given
        let jsonFileName = "photolistempty"
        
        // Then
        let sut: ResultModel = bundle.decodeFile(name: jsonFileName)!
        
        // When
        XCTAssert(sut.photos?.photo?.count == 0)
    }
    
    
    func testPhotolistResponseLastPage() {
        // Given
        let jsonFileName = "photolistlastpage"

        // Then
        let sut: ResultModel = bundle.decodeFile(name: jsonFileName)!

        // When
        XCTAssertTrue(sut.photos?.page == 9139)
        XCTAssertTrue(sut.photos?.perpage == 80)
        XCTAssertTrue(sut.photos?.pages == 9139)
    }

    
    func testPhotoURLResponse() {
        // Given
        let jsonFileName = "photoSize"

        // Then
        let sut: PhotoURLResult = bundle.decodeFile(name: jsonFileName)!
        
        // When
        XCTAssertNotNil(sut.sizes?.size)
        XCTAssertNotNil(sut.sizes?.size?.first(where: { $0.label == ImageSize.largeSquare.rawValue
        }))
        XCTAssertNotNil(sut.sizes?.size?.first(where: { $0.label == ImageSize.largeSquare.rawValue
        })?.source)
        
    }
    
    

    
}
