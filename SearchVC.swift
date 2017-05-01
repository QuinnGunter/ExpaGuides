//
//  SearchVC.swift
//  Expa Guides
//
//  Created by Quintin Gunter on 5/1/17.
//  Copyright © 2017 Quintin Gunter. All rights reserved.
//

import UIKit

class SearchVC: UICollectionViewController {
    
    var guideItem = [DataItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for i in 1...12 {
            
                guideItem.append(DataItem(title: "Title #\(i)", imageName: "img\(i).jpg"))
        
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guideItem.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DataItemCell
        let dataItem = guideItem[indexPath.row]
        cell.dataItem = dataItem
        
        return cell
    }


}
