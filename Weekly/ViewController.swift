//
//  ViewController.swift
//  Weekly
//
//  Created by Zachary Williams on 8/2/18.
//  Copyright © 2018 Zachary Williams. All rights reserved.
//

import UIKit

struct cellData
{
    let title : String?
    let expiration : Int? // Measured in days until reset.
    let maxCredits : Int?
    let currentCredits : Int?
}

class TableViewController: UITableViewController
{
    
    
    
    // Array of all cell data.
    var data : [cellData] = []
    
    
    
    
    override func viewDidLoad()
    {
        // Initialize data array with test data.
        data = [cellData(title: "item", expiration: 7, maxCredits: 6, currentCredits: 5)]
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Grabbing the first view in the xib file.
        let cell = Bundle.main.loadNibNamed("ItemCell", owner: self, options: nil)?.first as! ItemCell
        
        // Set up the cell data.
        cell.titleLabel.text = data[indexPath.row].title
        cell.expirationLabel.text = String(data[indexPath.row].expiration!)
        // TODO: Add stuff for the credit count.
        
        return cell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120;
    }
    
    
    
}

