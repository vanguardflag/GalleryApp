//
//  PhotoURLResult.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 05/02/2021.
//

import Foundation

struct PhotoURLResult: Decodable {
    var sizes:PhotoURLResultModel?
}

struct PhotoURLResultModel:Decodable {
    var canblog: Int?
    var canprint: Int?
    var candownload: Int?
    var size: [PhotosURLModel]?
}


struct PhotosURLModel:Decodable {
    var label: String?
    var width: Int?
    var height: Int?
    var source: String?
    var url: String?
    var media: String?
}
