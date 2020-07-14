//
//  BrowserVC.swift
//  Scoop
//
//  Created by Sai Balaji on 06/07/20.
//

import UIKit
import KSBGradientView
import WebKit
class BrowserVC: UIViewController {

    
    @IBOutlet weak var titlenewslbl: UILabel!
    

    var url: String?
    var newstitle: String?
   
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var closebtn: UIButton!
    
    @IBOutlet weak var titlebarview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titlebarview.applyHorizontalGradient(startcolor: UIColor.purple, endcolor: UIColor.systemPink)
         
        //print(url!)
       
      
        
      if let titles = newstitle
      {
        titlenewslbl.text = titles
      }
        
      if let newsurl = url
      {
        webView.load(URLRequest(url: URL(string: newsurl)!))
      }
        
       
       
    }
    

   
    @IBAction func closebtn(_ sender: UIButton) {
        
          dismiss(animated: true, completion: nil)
    }
    
}
