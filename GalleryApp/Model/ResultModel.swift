//
//  PhotosModel.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 04/02/2021.
//

import Foundation


struct ResultModel: Decodable {
    var photos: PhotoResultModel?
}

struct PhotoResultModel: Decodable {
    var page: Int?
    var pages: Int?
    var perpage: Int?
    var total: String?
    var photo: [PhotoInfoModel]?
}

struct PhotoInfoModel: Decodable {
    var id: String?
    var owner: String?
    var secret: String?
    var server: String?
    var farm: Int?
    var title: String?
    var ispublic: Int?
    var isfriend: Int?
    var isfamily: Int?
}
