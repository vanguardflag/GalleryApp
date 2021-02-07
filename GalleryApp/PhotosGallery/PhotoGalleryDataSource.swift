//
//  PhotoGalleryDataSource.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 07/02/2021.
//

import Foundation
import UIKit


class PhotoGalleryDataSource: NSObject,UICollectionViewDataSource{
    private var photos: [PhotoViewModel] = []
    
    
    func getDetailURL(for index: Int) -> URL?{
        return photos[index].detailUrl
    }
    
    func configure(photos: [PhotoViewModel]){
        self.photos.append(contentsOf: photos)
    }
    
    func reset(){
        self.photos.removeAll()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCollectionCell.identifier,
            for: indexPath
        ) as! PhotoCollectionCell
        cell.configureImage(
            with: photos[indexPath.row].listUrl)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
