//
//  APIConstant.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 04/02/2021.
//

import Foundation

struct APIConstant {
    static let appAPIKey = "f9cc014fa76b098f9e82f1c288379ea1"
    static let scheme = "https"
    static let host = "api.flickr.com"
    static let path = "/services/rest/"
    
    static let methodKey = "method"
    
    static let apiKey = "api_key"
    static let nojsoncallbackKey = "nojsoncallback"
    static let formatKey = "format"
    static let jsonType = "json"
    
    static let page = "page"
    static let tags = "tags"
    static let photoId = "photo_id"
    
    
    
}

enum Method: String {
    case getSize = "flickr.photos.getSizes"
    case searchPhoto = "flickr.photos.search"
}
