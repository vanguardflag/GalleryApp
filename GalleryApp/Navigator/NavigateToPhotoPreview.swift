//
//  NavigateToPhotoPreview.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 08/02/2021.
//

import Foundation
import UIKit

public protocol NavigateToPhotoPreviewProtocol {
    func present(imageURL: URL, viewController: UIViewController)
}


class NavigateToPhotoPreview: NavigateToPhotoPreviewProtocol {
    
    func present(imageURL: URL,viewController: UIViewController) {
        let vc = PhotoPreviewerViewController(imageURL: imageURL)
        viewController.present(vc, animated: true, completion: nil)
    }
}
