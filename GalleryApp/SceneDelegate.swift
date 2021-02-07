//
//  SceneDelegate.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 03/02/2021.
//

import UIKit
import Kingfisher

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController: UIViewController = PhotoGalleryBuilder().build()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        ImageCache.default.clearMemoryCache()
        ImageCache.default.cleanExpiredCache()
        ImageCache.default.clearDiskCache()
        ImageCache.default.cleanExpiredDiskCache()
    }
    
    
    
}

