//
//  ViewController.swift
//  GalleryApp
//
//  Created by Jalal Najafi on 03/02/2021.
//

import UIKit

protocol PhotoGalleryDisplayLogic: AnyObject {
    func displayPhotos(result: FetchPhoto.PresentResult)
}


class PhotoGalleryViewController: UIViewController {
    //MARK: Properties
    private var interactor: PhotoGalleryBussinesLogic
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemsPerRow: CGFloat = 2
    private var contentView = PhotoGalleryView(frame: UIScreen.main.bounds)
    private let searchbarView = UISearchBar()
    private var isLoading:Bool = false
    private let distanceUntileEndForLoadingMore: CGFloat = 200
    private let photoGalleryDataSource: PhotoGalleryDataSource = PhotoGalleryDataSource()
    
    //MARK: - Initial ViewCOntroller
    init(
        interactor: PhotoGalleryBussinesLogic
    ) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        
    }
    //MARK: - Private Func
    private func setupCollectionView() {
        contentView.collectionView.dataSource = photoGalleryDataSource
        contentView.collectionView.delegate = self
        contentView.collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCollectionCell.identifier)
    }
    
    private func setupNavigationBar(){
        navigationController?.setNavigationBarHidden(false, animated: true)
        searchbarView.delegate = self
        searchbarView.placeholder = "Search"
        navigationItem.titleView = searchbarView
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "OPS", message: "This image has not Large Image", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func handleViewWithData(_ photos: ([PhotoViewModel])) {
        photoGalleryDataSource.configure(photos: photos)
        DispatchQueue.main.async {
            self.contentView.configureView(hasData: true, isError: false)
            self.contentView.stopLoading()
            self.contentView.collectionView.reloadData()
        }
    }
    
    private func handleViewWithOutData(isError:Bool) {
        DispatchQueue.main.async {
            self.contentView.configureView(hasData: false, isError: isError)
        }
    }
}

// MARK: - Collection View Flow Layout Delegate
extension PhotoGalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = photoGalleryDataSource.getDetailURL(for: indexPath.row) else{
            showAlert()
            return
        }
        let vc = PhotoPreviewerViewController(imageURL: url)
        self.present(vc, animated: true, completion: nil)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }
}


extension PhotoGalleryViewController: UIScrollViewDelegate {
    public func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity _: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !isLoading,interactor.canFetchMorePhotos, distance < distanceUntileEndForLoadingMore {
            interactor.getPhotos(textSearch: "", isloadingMore: true)
            isLoading = true
            
        }
    }
}

//MARK: - Display Logic
extension PhotoGalleryViewController:PhotoGalleryDisplayLogic{
    
    func displayPhotos(result: FetchPhoto.PresentResult) {
        switch result {
        case .content(let photos):
            handleViewWithData(photos)
        case .empty:
            handleViewWithOutData(isError: false)
        case .error(_):
            handleViewWithOutData(isError: true)
        }
        isLoading = false
    }
}

// MARK: - Searchbar Delegation
extension PhotoGalleryViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        self.searchbarView.endEditing(true)
        self.contentView.collectionView.reloadData()
        photoGalleryDataSource.reset()
        contentView.startLoading()
        interactor.getPhotos(textSearch: text, isloadingMore: false)
        isLoading = true        
    }
    
}



