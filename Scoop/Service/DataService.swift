//
//  DataService.swift
//  Scoop
//
//  Created by Sai Balaji on 09/07/20.
//

import Foundation

class DataService
{
    static var shareddataobj = DataService()
    
    
    private var categoryarray = [Category(titleimgname: "Health.png", backgroundimagename: "running.png"),
    Category(titleimgname: "Science.png", backgroundimagename: "microscope.png"),
    Category(titleimgname: "Entertainment.png", backgroundimagename: "party.png"),
    Category(titleimgname: "Technology.png", backgroundimagename: "tech.png")]
    
   
    
    
    func getCategoryarray() -> [Category]
    {
        return categoryarray
    }
}
