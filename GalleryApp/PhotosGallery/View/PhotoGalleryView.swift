//
//  PhotoGalleryView.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 05/02/2021.
//

import Foundation
import UIKit
import SnapKit


class PhotoGalleryView: UIView {
    
    public lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .gray
        indicator.style = .medium
        return indicator
    }()
    
    
    public lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        imageView.isHidden = true
        return imageView
    }()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        backgroundColor = .white
        addSubviews()
        makeConstraints()
    }
    
    func addSubviews() {
        addSubview(imageView)
        addSubview(collectionView)
        addSubview(indicatorView)

    }
    
    func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.bottom.equalToSuperview().inset(50)
        }
    }
    
    
    
    public func configureView(hasData:Bool,isError:Bool){
        if hasData{
            imageView.isHidden = true
            collectionView.isHidden = false
        }else{
            imageView.isHidden = false
            collectionView.isHidden = true
            configureImageView(isError: isError)
        }
    }
    
    private func configureImageView(isError:Bool){
        if isError{
            imageView.image = UIImage(named: "opps")
        }else{
            imageView.image = UIImage(named: "empty")
        }
    }
    
    
    public func startLoading() {
        UIView.animate(withDuration: 0.3, animations: {
            self.indicatorView.alpha = 1
        }, completion: { _ in
            self.indicatorView.startAnimating()
        })
        
    }
    
    public func stopLoading() {
        UIView.animate(withDuration: 0.3, animations: {
            self.indicatorView.alpha = 0
        }, completion: { _ in
            self.indicatorView.stopAnimating()
        })
    }
}
