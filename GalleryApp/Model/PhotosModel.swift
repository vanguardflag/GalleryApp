//
//  PhotosModel.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 04/02/2021.
//

import Foundation


struct PhotosModel:Decodable {
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
