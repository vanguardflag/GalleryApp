//
//  PhotoGalleryBuilder.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 05/02/2021.
//

import Foundation
import UIKit

protocol ModuleBuilder {
    associatedtype Module: UIViewController
    func build() -> Module
}

public final class PhotoGalleryBuilder:ModuleBuilder{

    
    
    
    func build() -> some UIViewController {
        let presenter = PhotosGalleryPresenter()
        let interactor = PhotosGalleryInteractor(presenter: presenter)
        let viewController = PhotoGalleryViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
    

    
}
