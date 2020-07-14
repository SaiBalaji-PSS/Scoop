//
//  BrowserDVC.swift
//  Scoop
//
//  Created by Sai Balaji on 13/07/20.
//

import UIKit
import KSBGradientView
import WebKit

class BrowserDVC: UIViewController {


    //@IBOutlet weak var titleView: UIView!
   
    @IBOutlet weak var webView: WKWebView!
    var u: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
       view.applyHorizontalGradient(startcolor: UIColor.purple, endcolor: UIColor.systemPink)
       // print(u!)
        
        webView.load(URLRequest(url: URL(string:u!)!))
    }
    

   
    @IBAction func closebtn(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
