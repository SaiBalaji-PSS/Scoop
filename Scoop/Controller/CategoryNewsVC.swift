//
//  CategoryNewsVC.swift
//  Scoop
//
//  Created by Sai Balaji on 10/07/20.
//

import UIKit
import Network
import SVProgressHUD

class CategoryNewsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var articles = [Articles]()
    var newsurl: String?
    var ntitle: String?
    let monitor = NWPathMonitor()
    var i:Int!
    @IBOutlet weak var tv: UITableView!
    
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

        if i == 0
        {
           
            title = "Health News"
            
            if tv.visibleCells.isEmpty
            {
                SVProgressHUD.show(withStatus: "Getting news...")
                SVProgressHUD.setBorderColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                SVProgressHUD.setBorderWidth(2)
                SVProgressHUD.setHapticsEnabled(true)
                SVProgressHUD.setRingThickness(4)
            }
                
            
            
            
            tv.delegate = self
                         tv.dataSource = self
            NetworkService.sharedobj.getHealthNews { (articles) in
               
                self.articles = articles
                print(self.articles.count)
                self.tv.reloadData()
                
                SVProgressHUD.dismiss()
              
            }
        }
        
        else if i == 3
        {
           title = "Technology News"
            
            if tv.visibleCells.isEmpty
            {
                SVProgressHUD.show(withStatus: "Getting news...")
                SVProgressHUD.setBorderColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                SVProgressHUD.setBorderWidth(2)
                SVProgressHUD.setHapticsEnabled(true)
                SVProgressHUD.setRingThickness(4)
            }
            
            tv.delegate = self
            tv.dataSource = self
            
            NetworkService.sharedobj.getTechNews { (a) in
                self.articles = a
                print(a.count)
                DispatchQueue.main.async {
                    self.tv.reloadData()
                }
              
                SVProgressHUD.dismiss()
            }
        }
        
        else if i == 2
        {
            title = "Entertaiment News"
            if tv.visibleCells.isEmpty
            {
                SVProgressHUD.show(withStatus: "Getting news...")
                SVProgressHUD.setBorderColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                SVProgressHUD.setBorderWidth(2)
                SVProgressHUD.setHapticsEnabled(true)
                SVProgressHUD.setRingThickness(4)
            }
            
            NetworkService.sharedobj.getEntertainmentNews { (a) in
                self.articles = a
                DispatchQueue.main.async {
                    self.tv.reloadData()
                }
                SVProgressHUD.dismiss()
            }
            
            
        }
        
        else if i == 1
        {
            title = "Science News"
            if tv.visibleCells.isEmpty
            {
                SVProgressHUD.show(withStatus: "Getting news...")
                SVProgressHUD.setBorderColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                SVProgressHUD.setBorderWidth(2)
                SVProgressHUD.setHapticsEnabled(true)
                SVProgressHUD.setRingThickness(4)
            }
            
            NetworkService.sharedobj.getScienceNews { (a) in
                self.articles = a
                DispatchQueue.main.async {
                    self.tv.reloadData()
                }
                
                SVProgressHUD.dismiss()
            }
        }
       
        
       
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cellnews") as? HeadLinesCellTableViewCell
        {
            cell.updateCell(title: articles[indexPath.row].title ?? "No title", body: articles[indexPath.row].content ?? "No body", imgurl: articles[indexPath.row].urlToImage ?? "https://en.wikipedia.org/wiki/Pages_(word_processor)#/media/File:Pages_Icon.png")
            
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nurl = articles[indexPath.row].url
        {
            self.newsurl = nurl
        }
        
        if let ntit = articles[indexPath.row].title
        {
            self.ntitle = ntit
        }
        
        performSegue(withIdentifier: "bsegue", sender: self)
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .normal, title: "Share") { (UITableViewRowAction, IndexPath) in
            
           
            self.socialMediaShare(index: indexPath.row)
            
            
        }
        
        action.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        let saveAction = UITableViewRowAction(style: .default, title: "Bookmark") { (UITableViewRowAction, IndexPath) in
            self.saveData(i: indexPath.row)
        }
        
        saveAction.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        return [action,saveAction]
    }
    
    
    
    
    func saveData(i: Int)
    {
        guard let mc = AppDel?.persistentContainer.viewContext else {return}
        
        let a = DArticle(context: mc)
        a.title = articles[i].title!
        a.articleurl = articles[i].url!
        
        do
        {
            try mc.save()
            let ac = UIAlertController(title: "Info", message: "Article added to Bookmark", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(ac, animated: true, completion: nil)
           
        }
        
        catch
        {
            print(error.localizedDescription)
        }
        
        
        
    }
    
    
    
    
    func socialMediaShare(index: Int)
    {
        let vc = UIActivityViewController(activityItems: [articles[index].url ?? "Not found"], applicationActivities: [])
        
        
        
        present(vc, animated: true, completion: nil)
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? BrowserVCsecond
        {
            destinationVC.url = self.newsurl
            destinationVC.title = self.ntitle
        }
    }
    
    
  
    

    

}
