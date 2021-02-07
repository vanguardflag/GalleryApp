//
//  PhotoPreviewerViewController.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 05/02/2021.
//

import Foundation
import UIKit


class PhotoPreviewerViewController:UIViewController{
    //MARK: Properties
    let imageURL:URL
  
    lazy var contentView: PhotoPreviewerView = {
        let view = PhotoPreviewerView(frame: UIScreen.main.bounds)
        view.closeButtonAction = {[weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        view.configure(imageURL: imageURL)
        return view
    }()

    //MARK: - Initial ViewCOntroller
    init(
        imageURL:URL
    ) {
        self.imageURL = imageURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func loadView() {
        view = contentView
        // make additional setup of view or save references to subviews
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
    }
    //MARK: - Private Func
    
    
    private func setupNavigationBar(){
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}

