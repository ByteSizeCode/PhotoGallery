/*
 * Copyright (C) 2015 - 2016, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.com>.
 * All rights reserved.
 */

import UIKit
import Material

class PhotoCollectionViewCell: UICollectionViewCell {
    open var imageView: UIImageView!
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareImageView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareImageView()
    }
}

extension PhotoCollectionViewCell {
    fileprivate func prepareImageView() {
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        contentView.clipsToBounds = true
        contentView.layout(imageView).edges()
    }
}
