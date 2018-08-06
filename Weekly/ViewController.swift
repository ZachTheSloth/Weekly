//
//  ViewController.swift
//  Weekly
//
//  Created by Zachary Williams on 8/2/18.
//  Copyright © 2018 Zachary Williams. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController
{

    
    
    
    // Search controller.
    let searchController = UISearchController(searchResultsController: nil)
    
    // Custom Colors
    let jazzberryJam = UIColor(red:0.80, green:0.17, blue:0.39, alpha:1.00)
    
    
    
    override func viewDidLoad()
    {
        configureSerachBar()
    }
    
    
    
    
   // Constructs the requested cell by the table view, by applying the correct data to the xib template.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Grabbing the first view in the xib file.
        let cell = Bundle.main.loadNibNamed("ItemCell", owner: self, options: nil)?.first as! ItemCell
        
        // Set up the title & expiration.
        cell.titleLabel.text = Controller.getCellTitle(cellIndex: indexPath.row)
        cell.expirationLabel.text = String(Controller.getCellDaysUntilReset(cellIndex: indexPath.row))
        
        // Set up the cell's credit slots with correct images.
        let maxCredits = Controller.getCellMaxCredits(cellIndex: indexPath.row)
        let currentCredits = Controller.getCellCurrentCredits(cellIndex: indexPath.row)
        var listOfCreditSlots = [cell.creditSlot1ImageView,
                                 cell.creditSlot2ImageView,
                                 cell.creditSlot3ImageView,
                                 cell.creditSlot4ImageView,
                                 cell.creditSlot5ImageView,
                                 cell.creditSlot6ImageView]
        
        for index in 0...(maxCredits - 1)
        { listOfCreditSlots[index]?.image = UIImage(named: "credit_empty") }
        
        for index in 0...(currentCredits - 1)
        { listOfCreditSlots[index]?.image = UIImage(named: "credit_full") }
        
        // Set the selection color.
        let bgColorView = UIView()
        bgColorView.backgroundColor = jazzberryJam
        cell.selectedBackgroundView = bgColorView
        
        // Return the constructed cell.
        return cell
    }
    
    
    
    
    // CONFIGURATION METHODS
    
    
    // Sets the height of the table cells.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    { return 120 }
    
    
    // Sets the number of rows in the table view (should be equal to the # of entries in the data).
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    { return Controller.getCellDataContainerEntityCount()! }
    
    
    // Style of status bar (light/dark).
    override var preferredStatusBarStyle: UIStatusBarStyle
    { return .lightContent }
    
    
    // Style of the search bar.
    func configureSerachBar()
    {
        // Instantiate the search controller.
        navigationItem.searchController = searchController
        
        // Configure visuals.
        navigationItem.hidesSearchBarWhenScrolling = true // Hide/show search bar when scrolling.
        searchController.searchBar.tintColor = .white  // Make the 'cancel' text white.
    }
    
    
    
}

