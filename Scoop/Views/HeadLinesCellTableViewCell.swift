//
//  HeadLinesCellTableViewCell.swift
//  Scoop
//
//  Created by Sai Balaji on 06/07/20.
//

import UIKit
import SDWebImage
class HeadLinesCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var headlinesimageview: UIImageView!
    

    @IBOutlet weak var headlinestitlelbl: UILabel!
    
    @IBOutlet weak var headlinesbodylbl: UILabel!
    
    
    
    func updateCell(title: String,body: String,imgurl: String)
    {
        headlinestitlelbl.text = title
        headlinesbodylbl.text = body
        headlinesimageview.sd_setImage(with: URL(string: imgurl), completed: nil)
        
        if headlinesimageview.image == nil
        {
            headlinesimageview.image = UIImage(named: "no-image-2.png")
        }
  
    
    
}
}
