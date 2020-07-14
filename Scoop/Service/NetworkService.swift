//
//  NetworkService.swift
//  Scoop
//
//  Created by Sai Balaji on 06/07/20.
//

import Foundation



class NetworkService{
    
    
    static  let  sharedobj = NetworkService()
    let session = URLSession.shared
    
   private let HEALTH_URL = "https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=81ac0722281749f6b36e95ebc7d01637"
   private let HEADLINES_URL = "https://newsapi.org/v2/top-headlines?country=in&apiKey=81ac0722281749f6b36e95ebc7d01637"
   private let TECH_URL = "http://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=81ac0722281749f6b36e95ebc7d01637"
   private let ENTERTAINMENT_URL = "http://newsapi.org/v2/top-headlines?country=in&category=entertainment&apiKey=81ac0722281749f6b36e95ebc7d01637"
    private let SCIENCE_URL = "http://newsapi.org/v2/top-headlines?country=in&category=science&apiKey=81ac0722281749f6b36e95ebc7d01637"
    
   
    public func getHeadLines(onSuccess: @escaping ([Articles]) -> Void)
    {
        let datatask = session.dataTask(with: URL(string: HEADLINES_URL)!, completionHandler: { (data, response, error) in
            
            
            if response == nil
            {
                return
            }
            
            
            DispatchQueue.main.async {
                
                do
                {
                    let decoder = try JSONDecoder().decode(Welcome.self, from: data!)
                    onSuccess(decoder.articles!)
                }
                
                catch
                {
                    print(error.localizedDescription)
                }
                
               
            }
            
            
            
            
            
        
        })
        
        datatask.resume()
        
        
        
    }
    
    
    
    func getHealthNews(onSuccess: @escaping([Articles]) -> Void)
    {
        
       
        let datatask = session.dataTask(with: URL(string: HEALTH_URL)!, completionHandler: { (data, response, error) in
            
            if response == nil
            {
                
                return
            }
            DispatchQueue.main.async {
                
                do
                {
                    let decoder = try JSONDecoder().decode(Welcome.self, from: data!)
                    onSuccess(decoder.articles!)
                }
                
                catch
                {
                    print(error.localizedDescription)
                }
                
               
            }
            
            
        
            
            
        
        })
        
        datatask.resume()
        
        
       
    }
    
    func getTechNews(onsucess: @escaping([Articles]) ->Void)
    {
        let dataTask = session.dataTask(with: URL(string: TECH_URL)!) { (data, response, error) in
            
            if response == nil
            {
                
                return
            }
            
            do
            {
                let decoder = try  JSONDecoder().decode(Welcome.self, from: data!)
                onsucess(decoder.articles!)
            }
            
            catch
            {
                print(error.localizedDescription)
            }
            
            
        }
        
        dataTask.resume()
    }
    
    
    func getEntertainmentNews(onSuccess: @escaping([Articles]) -> Void)
    {
        
        
        
        let dataTask = session.dataTask(with: URL(string: ENTERTAINMENT_URL)!) { (data, response, error) in
            
            
            if response == nil
            {
                
                return
            }
            DispatchQueue.main.async {
                do
                {
                let decoder = try JSONDecoder().decode(Welcome.self, from: data!)
                    onSuccess(decoder.articles!)
                }
                catch
                {
                    print(error.localizedDescription)
                }

            }
        }
        
        
        dataTask.resume()
    }
    
    
    func getScienceNews(onSuccess: @escaping([Articles]) -> Void)
    {
        let dataTask = session.dataTask(with: URL(string: SCIENCE_URL)!) { (data, response, error) in
            
            
            if response == nil
            {
                return
            }
            
            DispatchQueue.main.async {
                do
                {
                    let decoder = try JSONDecoder().decode(Welcome.self, from: data!)
                    onSuccess(decoder.articles!)
                }
                
                catch
                {
                    print(error.localizedDescription)
                }

            }
        }
        
        dataTask.resume()
    }
    
        
        
    
        
        
        
        
            
            
  }
        
    
        
        
        
        
        
        
        
        
        
        
        
    
    
    

