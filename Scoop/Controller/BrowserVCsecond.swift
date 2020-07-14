//
//  BrowserVCsecond.swift
//  Scoop
//
//  Created by Sai Balaji on 11/07/20.
//

import UIKit
import SVProgressHUD
import KSBGradientView
import WebKit
class BrowserVCsecond: UIViewController, WKNavigationDelegate {

   

 
    

    var url: String?
    var ntitle: String!
   
    
    @IBOutlet weak var webviewnews: WKWebView!
    
   
    
    @IBOutlet weak var titlelbl: UILabel!
    
    @IBOutlet weak var titleview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleview.applyHorizontalGradient(startcolor: UIColor.purple, endcolor: UIColor.systemPink)
      
        
       if let u = url
       {
         print("URL IS \(u)")
        webviewnews.load(URLRequest(url: URL(string:u)!))
       
       }
       else
       {
        let ac = UIAlertController(title: "Error", message: "URL Not found", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
       }
       
       
       if let titlenews = ntitle
       {
        titlelbl.text = titlenews
       }
       else
       {
        titlelbl.text = " "
       }
       

    }
    

    
   
    @IBAction func closebtnclicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
