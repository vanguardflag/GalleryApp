//
//  PhotoGalleryDataFlow.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 05/02/2021.
//

import Foundation



enum FetchPhoto {

    public struct Response {
        var result: Result<[PhotoURLResultModel], ErrorType>
    }

    public enum PresentResult {
        case content([PhotoViewModel])
        case empty
        case error(ErrorType)
    }
}

enum ErrorType: Error {
    case loadingFailed
}
