//
//  ViewController.swift
//  Scoop
//
//  Created by Sai Balaji on 06/07/20.
//

import UIKit
import CoreData
import SDWebImage
import SVProgressHUD
import Network

let AppDel = UIApplication.shared.delegate as? AppDelegate

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
   
   var monitor = NWPathMonitor()
    var  articles = [Articles]()
    var newsurl: String!
    var newstitle: String!
    let d = DArticle()
    
    
    @IBOutlet weak var navigationbar: UINavigationItem!
    
    
    @IBOutlet weak var headlinestableview: UITableView!
    
    override func loadView() {
        super.loadView()
        print("Hello")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        monitor.pathUpdateHandler = { path in
            
            if path.status == .unsatisfied
            {
                SVProgressHUD.showError(withStatus: "No internet connection")
                return
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        if headlinestableview.visibleCells.isEmpty
        {
            SVProgressHUD.show(withStatus: "Getting headlines")
            SVProgressHUD.setBorderColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            SVProgressHUD.setBorderWidth(2)
            SVProgressHUD.setHapticsEnabled(true)
            SVProgressHUD.setRingThickness(4)
            
        }
        
       
        
        
        
        title = "Headlines"
        self.headlinestableview.delegate = self
        self.headlinestableview.dataSource = self

      
     
        
        NetworkService.sharedobj.getHeadLines { (a) in
            self.articles = a
            
            print(self.articles.count)
            
            self.headlinestableview.reloadData()
            
            SVProgressHUD.dismiss()
            
        }
        
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("dfgdf\(articles.count)")
        return articles.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
       if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HeadLinesCellTableViewCell
        {
            
            let data = articles[indexPath.row]
    
            cell.updateCell(title:data.title ?? "Not Found", body: data.content ?? "No Body", imgurl: data.urlToImage ?? "https://en.wikipedia.org/wiki/Pages_(word_processor)#/media/File:Pages_Icon.png")
            
          
           
        
            return cell
            
        }
        
        
        return UITableViewCell()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newsurl = articles[indexPath.row].url!
        newstitle = articles[indexPath.row].title!
        performSegue(withIdentifier: "segue", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? BrowserVC
        {
            destinationVC.url = newsurl
            destinationVC.newstitle = newstitle
        }
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .normal, title: "Share") { (UITableViewRowAction, IndexPath) in
            
           
            self.socialMediaShare(index: indexPath.row)
            
            
        }
        
        action.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        
        let save = UITableViewRowAction(style: .normal, title: "Bookmark") { (UITableViewRowAction, IndexPath) in
            self.saveData(i: IndexPath.row)
        }
        
        save.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
       
        
    
        
        
        return [action, save]
    }
    
    
    
    func saveData(i: Int)
    {
        guard let managedContext = AppDel?.persistentContainer.viewContext else {return }
        
        let articetobesave = DArticle(context: managedContext)
        
        articetobesave.title = articles[i].title!
        articetobesave.articleurl = articles[i].url!
        
        do{
          try  managedContext.save()
            
            let ac = UIAlertController(title: "Info", message: "Article added to Bookmark", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(ac, animated: true, completion: nil)
            
            
        }
        
        catch{
            print(error.localizedDescription)
        }
        
        
        
    }
    
    
    
    
    func socialMediaShare(index: Int)
    {
        let vc = UIActivityViewController(activityItems: [articles[index].url ?? "Not found"], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }

    @IBAction func refreshbtn(_ sender: Any) {
        
        
        NetworkService.sharedobj.getHeadLines { (a) in
            
            SVProgressHUD.show(withStatus: "Refreshing...")
            
            self.articles = a
            self.headlinestableview.reloadData()
            
            SVProgressHUD.dismiss()
        }
        
    }
}

