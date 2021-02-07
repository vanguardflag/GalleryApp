//
//  PhotoPreviewerView.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 05/02/2021.
//

import Foundation
import UIKit
import Kingfisher


class PhotoPreviewerView: UIView {
    public var closeButtonAction: (() -> Void)?

    private(set) lazy var closeButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.setImage(UIImage(named: "closeX"), for: .normal)
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func commonInit() {
        backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        addSubviews()
        makeConstraints()
    }

    func addSubviews() {
        addSubview(imageView)
        addSubview(closeButton)
    }

    func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview().inset(10)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(10)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }

    }

    public func configure(imageURL:URL){
        let placeholderImage = UIImage(named: "placeHolder")
        let resource = ImageResource(downloadURL: imageURL)
        KingfisherManager.shared.retrieveImage(with: resource) { result in
            switch result{
            case .success(let image):
                self.imageView.image = image.image
            case .failure(_):
                self.imageView.image = placeholderImage
            }
        }
    }
    
    @objc func closeView(){
        closeButtonAction?()
    }
}
