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
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    
    override func viewDidLoad()
    {
        // Initialize data array with test data.
        data = [cellData(title: "item", expiration: 7, maxCredits: 6, currentCredits: 5),
                cellData(title: "item", expiration: 7, maxCredits: 6, currentCredits: 4),
                cellData(title: "item", expiration: 7, maxCredits: 6, currentCredits: 3),
                cellData(title: "item", expiration: 7, maxCredits: 6, currentCredits: 2),
                cellData(title: "item", expiration: 7, maxCredits: 6, currentCredits: 1)]
        
        configureSerachBar()
    }
    
    
    
    
    func configureSerachBar()
    {
        // Instantiate the search controller.
        navigationItem.searchController = searchController
        
        // Configuration
        navigationItem.hidesSearchBarWhenScrolling = false // Hide/show search bar when scrolling.
        searchController.searchBar.tintColor = .white  // Make the 'cancel' text white.
    }
    
    
    
    
   // Constructs the requested cell by the table view, by applying the correct data to the xib template.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Grabbing the first view in the xib file.
        let cell = Bundle.main.loadNibNamed("ItemCell", owner: self, options: nil)?.first as! ItemCell
        let cellData = data[indexPath.row]
        
        // Set up the cell text data.
        cell.titleLabel.text = cellData.title
        cell.expirationLabel.text = String(cellData.expiration!)
        
        // Set up the cell's credit slots with correct images.
        let maxCredits = cellData.maxCredits
        let currentCredits = cellData.currentCredits
        var listOfCreditSlots = [cell.creditSlot1ImageView, cell.creditSlot2ImageView, cell.creditSlot3ImageView, cell.creditSlot4ImageView, cell.creditSlot5ImageView, cell.creditSlot6ImageView]
        
        for index in 0...(currentCredits! - 1)
        { listOfCreditSlots[index]?.image = UIImage(named: "credit_full") }
        
        for index in currentCredits!...(maxCredits! - 1)
        { listOfCreditSlots[index]?.image = UIImage(named: "credit_empty") }
        
        // Return the constructed cell.
        return cell
    }
    
    
    
    
    // CONFIGURATION METHODS
    
    // Sets the height of the table cells.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    { return 120 }
    
    // Sets the number of rows in the table view (should be equal to the # of entries in the data).
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    { return data.count }
    
    // Style of status bar (light/dark).
    override var preferredStatusBarStyle: UIStatusBarStyle
    { return .lightContent }
    
    
    
}

