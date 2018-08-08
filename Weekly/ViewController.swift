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
 
    
    
    // IBOutlets
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    
    
    override func viewDidLoad()
    {
        // Set the theme (for testing).
        ThemeManager.setCurrentTheme(themeName: "Rich Red", isInverted: false)
        
        configureTableView()
        configureHeader()
        configureBarButtons()
        configureNavBar()
    }
    
    
    
    
   // Constructs the requested cell by the table view, by applying the correct data to the xib template.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // Grabbing the first view in the xib file.
        let cell = Bundle.main.loadNibNamed("ItemCell", owner: self, options: nil)?.first as! ItemCell
        
        // Set the background & selection color of the entire cell.
        let bgColorView = UIView()
        bgColorView.backgroundColor = ThemeManager.getCurrentThemeColor(isBGColor: true)
        cell.backgroundColor = ThemeManager.getCurrentThemeColor(isBGColor: true)
        cell.selectedBackgroundView = bgColorView
        
        // Set up the text and color for the title and expiration labels.
        cell.titleLabel.text = Controller.getCellTitle(cellIndex: indexPath.row)
        cell.titleLabel.textColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        cell.expirationLabel.text = String(Controller.getCellDaysUntilReset(cellIndex: indexPath.row))
        cell.expirationLabel.textColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        
        // Set up the cell's credit slots with correct images.
        let maxCredits = Controller.getCellMaxCredits(cellIndex: indexPath.row)
        let currentCredits = Controller.getCellCurrentCredits(cellIndex: indexPath.row)
        var listOfCreditSlots = [cell.creditSlot1ImageView,
                                 cell.creditSlot2ImageView,
                                 cell.creditSlot3ImageView,
                                 cell.creditSlot4ImageView,
                                 cell.creditSlot5ImageView,
                                 cell.creditSlot6ImageView]
        
        // Set up which credit slots should be empty.
        for index in 0...(maxCredits - 1)
        {
            listOfCreditSlots[index]?.image = UIImage(named: "credit_empty")
            listOfCreditSlots[index]?.setImageColor(color: ThemeManager.getCurrentThemeColor(isBGColor: false)!)
        }
        
        // Set up which credit slots should be full.
        for index in 0...(currentCredits - 1)
        {
            listOfCreditSlots[index]?.image = UIImage(named: "credit_full")
            listOfCreditSlots[index]?.setImageColor(color: ThemeManager.getCurrentThemeColor(isBGColor: false)!)
        }
        
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
    
    
    // Set up styling for the table view as a whole.
    func configureTableView()
    { tableView.backgroundColor = ThemeManager.getCurrentThemeColor(isBGColor: true) }
    
    
    // Style the title text color.
    func configureHeader()
    {
        let textAttributes = [NSAttributedString.Key.foregroundColor: ThemeManager.getCurrentThemeColor(isBGColor: false)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
    }
    
    
    // Style the bar button items.
    func configureBarButtons()
    {
        editButton.tintColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        addButton.tintColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
    }
    
    
    // Configure nav bar background color, as well as default text color.
    func configureNavBar()
    {
        navigationController?.navigationBar.barTintColor = ThemeManager.getCurrentThemeColor(isBGColor: true)
        navigationController?.navigationBar.tintColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
    }
    
    
    
}

