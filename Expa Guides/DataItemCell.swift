//
//  DataItemCell.swift
//  Expa Guides
//
//  Created by Quintin Gunter on 5/1/17.
//  Copyright © 2017 Quintin Gunter. All rights reserved.
//

import UIKit


    class DataItemCell: UICollectionViewCell {
        
        @IBOutlet private weak var dataItemImageView: UIImageView!
        
        var dataItem: DataItem? {
            didSet {
                if let dataItem = dataItem {
                    dataItemImageView.image = UIImage(named: dataItem.imageName)
        }
    }
}
}
