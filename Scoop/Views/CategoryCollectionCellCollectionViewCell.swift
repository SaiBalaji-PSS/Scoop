//
//  CategoryCollectionCellCollectionViewCell.swift
//  Scoop
//
//  Created by Sai Balaji on 09/07/20.
//

import UIKit

class CategoryCollectionCellCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var categorytitleimg: UIImageView!
    
    @IBOutlet weak var backgroundimg: UIImageView!
    
    func updateCell(imagename: String,categorytitleimage: String)
    {
        self.backgroundimg.image = UIImage(named: imagename)
        self.categorytitleimg.image = UIImage(named: categorytitleimage)
    
    }
}
