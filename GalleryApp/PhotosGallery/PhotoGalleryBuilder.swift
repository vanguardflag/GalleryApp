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

public class PhotoGalleryBuilder: ModuleBuilder{
    private var navigateToPhototPreview: NavigateToPhotoPreviewProtocol?
    
    public init() {}
    
    
    @discardableResult
    public func setNavigators(_ navigators: NavigateToPhotoPreviewProtocol) -> Self {
        self.navigateToPhototPreview = navigators
        return self
    }
    
    func build() -> some UIViewController {
        guard let navigateToPhototPreview = self.navigateToPhototPreview else {
            preconditionFailure("dependencies are not set")
        }
        let presenter = PhotosGalleryPresenter()
        let interactor = PhotosGalleryInteractor(presenter: presenter)
        let viewController = PhotoGalleryViewController(interactor: interactor,
                                                        navigateToPhototPreview: navigateToPhototPreview)
        presenter.viewController = viewController
        return viewController
    }
}
