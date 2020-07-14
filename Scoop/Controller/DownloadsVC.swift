//
//  DownloadsVC.swift
//  Scoop
//
//  Created by Sai Balaji on 13/07/20.
//

import UIKit
import CoreData



class DownloadsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet weak var downloadsTableView: UITableView!
    
    var savedArticles = [DArticle]()
    
    
    
    var url: String!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        
        
        
        downloadsTableView.delegate = self
        downloadsTableView.dataSource = self
      
      
         
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Bookmarks"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "downloadcell")
        {
            cell.textLabel?.text = savedArticles[indexPath.row].title!
            return cell
        }
        
        return UITableViewCell()
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        url = savedArticles[indexPath.row].articleurl!
        
        performSegue(withIdentifier: "ss", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let des = segue.destination as? BrowserDVC
        {
            des.u = url!
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (UITableViewRowAction, IndexPath) in
         
            
            self.deleteData(i: indexPath.row)
            self.getData()
            
            self.downloadsTableView.reloadData()
            
        }
        
        
        let shareAction = UITableViewRowAction(style: .normal, title: "Share") { (UITableViewRowAction, IndexPath) in
            self.sociaMediaShare(url: self.savedArticles[IndexPath.row].articleurl ?? "No url found")
            
            
        }
        
        shareAction.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        return [deleteAction,shareAction]
    }
    
    func deleteData(i: Int)
    {
        guard let mc = AppDel?.persistentContainer.viewContext else {return }
        
        mc.delete(savedArticles[i])
        
        
        do
        {
            try mc.save()
        }
        
        catch
        {
            print(error.localizedDescription)
        }
        
    }
    
    
    
    
    
    
    
    
    func getData()
    {
        let fetchrequest = NSFetchRequest<DArticle>(entityName: "DArticle")
        
        do
        {
            guard  let mc = AppDel?.persistentContainer.viewContext else {return }
            
            savedArticles = try mc.fetch(fetchrequest)
           
            print("Fetched..................")
            
            
            self.downloadsTableView.reloadData()
            
            
        }
        
        catch
        {
            print(error.localizedDescription)
        }
    }
    
    
    
    func sociaMediaShare(url: String)
    {
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
        
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
  

}
