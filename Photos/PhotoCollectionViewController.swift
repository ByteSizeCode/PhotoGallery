/*
 * Copyright (C) 2015 - 2016, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.com>.
 * All rights reserved.
 */

import UIKit
import Material

class PhotoCollectionViewController: UIViewController {
  fileprivate var collectionView: UICollectionView!
  fileprivate var images = [UIImage]()
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    preparePhotos()
    prepareTabBar()
    prepareCollectionView()
    prepareToolbar()
  }
}

fileprivate extension PhotoCollectionViewController {
  func preparePhotos() {
    PhotosDataSource.forEach { [weak self] in
      guard let image = UIImage(named: $0) else {
        return
      }
      self?.images.append(image)
    }
  }
  
  func prepareTabBar() {
    tabsController?.tabBar.motionIdentifier = "options"
  }
  
  func prepareCollectionView() {
    let columns: CGFloat = .phone == Device.userInterfaceIdiom ? 4 : 11
    let w: CGFloat = (view.bounds.width - columns - 1) / columns
    
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 1
    layout.minimumInteritemSpacing = 1
    layout.scrollDirection = .vertical
    layout.itemSize = CGSize(width: w, height: w)
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
    collectionView.backgroundColor = .clear
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.showsHorizontalScrollIndicator = false
    view.layout(collectionView).horizontally().top().bottom()
    
    collectionView.reloadData()
  }
  
  func prepareToolbar() {
    guard let toolbar = toolbarController?.toolbar else {
      return
    }
    
    //Get today's date
    let dateFormatter = DateFormatter()
    dateFormatter.setLocalizedDateFormatFromTemplate("EEE MMM d yyyy")
    let today = dateFormatter.string(from: Date())
    
    toolbar.titleLabel.text = "\(today)"
    toolbar.detailLabel.text = ""
    toolbar.leftViews = []
  }
}

extension PhotoCollectionViewController: UICollectionViewDataSource {
  @objc
  open func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  @objc
  open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  @objc
  open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
    
    cell.imageView.image = images[indexPath.item]
    cell.imageView.motionIdentifier = "photo_\(indexPath.item)"
    cell.transition(.fadeOut, .scale(0.75))
    
    return cell
  }
}

extension PhotoCollectionViewController: UICollectionViewDelegate {
  @objc
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    toolbarController?.transition(to: PhotoViewController(index: indexPath.item))
  }
}

