//
//  PhotoCollectionCell.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 05/02/2021.
//

import Foundation
import UIKit
import Kingfisher

class PhotoCollectionCell: UICollectionViewCell {
    static let identifier = "photoCellIdentifier"
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()

    override func prepareForReuse() {
        imageView.image = nil
    }
    private override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {
        contentView.addSubview(imageView)
    }

    private func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    func configureImage(with url: URL?) {
        let placeholderImage = UIImage(named: "placeHolder")
        guard let url = url else {
            imageView.image = placeholderImage
            return
        }
        let resource = ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resource) { result in
            switch result{
            case .success(let image):
                self.imageView.image = image.image
            case .failure(_):
                self.imageView.image = placeholderImage
            }
        }
    }
}
