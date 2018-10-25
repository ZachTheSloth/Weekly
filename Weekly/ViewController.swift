//
//  ViewController.swift
//  Weekly
//
//  Created by Zachary Williams on 8/2/18.
//  Copyright © 2018 Zachary Williams. All rights reserved.
//

import UIKit

class TableViewController : UITableViewController
{
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    /*
    -----------------------------
    VIEW INITIALIZATION FUNCTIONS
    -----------------------------
    */
    
    
    override func viewDidLoad()
    {
        // check if there is a current theme set. if not, set one.
        if(ThemeManager.getCurrentThemeColor(isBGColor: false) == nil)
        { ThemeManager.setCurrentTheme(themeName: "Blue Night", isInverted: false) }
        
        configureViewColors()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        configureViewColors()
        tableView.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    { configureViewColors() }
    
    
    /*
    -----------------------------------------------
    TABLE VIEW CONSTRUCTION/CONFIGURATION FUNCTIONS
    -----------------------------------------------
    */
    
    
    /**
    Constructs one cell for the table view.
    Called as many times as defined in the tableView(didSelectRowAt) function.
    */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = Bundle.main.loadNibNamed("ItemCell", owner: self, options: nil)?.first as! ItemCell
        
        // set the background & selection color of the entire cell
        let bgColorView = UIView()
        bgColorView.backgroundColor = ThemeManager.getCurrentThemeColor(isBGColor: true)
        cell.backgroundColor = ThemeManager.getCurrentThemeColor(isBGColor: true)
        cell.selectedBackgroundView = bgColorView
        
        // set up the text/color for the title and expiration labels
        cell.titleLabel.text = Controller.getCellTitle(cellIndex: indexPath.row)
        cell.titleLabel.textColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        cell.expirationLabel.text = String(Controller.getCellDaysUntilReset(cellIndex: indexPath.row))
        cell.expirationLabel.textColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        
        // set up the cell's credit slots with correct images
        let maxCredits = Controller.getCellMaxCredits(cellIndex: indexPath.row)
        let currentCredits = Controller.getCellCurrentCredits(cellIndex: indexPath.row)
        var listOfCreditSlots = [cell.creditSlot1ImageView,
                                 cell.creditSlot2ImageView,
                                 cell.creditSlot3ImageView,
                                 cell.creditSlot4ImageView,
                                 cell.creditSlot5ImageView,
                                 cell.creditSlot6ImageView]
        
        // set up which credit slots should be empty
        for index in 0..<(maxCredits) {
            listOfCreditSlots[index]?.image = UIImage(named: "credit_empty")
            listOfCreditSlots[index]?.setImageColor(color: ThemeManager.getCurrentThemeColor(isBGColor: false)!)
        }
        
        // set up which credit slots should be full
        for index in 0..<(currentCredits) {
            listOfCreditSlots[index]?.image = UIImage(named: "credit_full")
            listOfCreditSlots[index]?.setImageColor(color: ThemeManager.getCurrentThemeColor(isBGColor: false)!)
        }
        
        return cell
    }
    
    
    /// Removes 1 credit from the selected view, then updates the table view.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // get cell info (that won't change)
        let title = Controller.getCellTitle(cellIndex: indexPath.row)
        let resetCycleLength = Controller.getCellResetCycleLength(cellIndex: indexPath.row)
        let daysUntilReset = Controller.getCellDaysUntilReset(cellIndex: indexPath.row)
        let maxCredits = Controller.getCellMaxCredits(cellIndex: indexPath.row)
        
        // get current credit count for the selected cell, subtract one
        var currentCredits = Controller.getCellCurrentCredits(cellIndex: indexPath.row)
        if currentCredits > 0
        { currentCredits -= 1 }
        
        // update selected cell
        Controller.updateCell(index: indexPath.row, title: title, resetCycleLength: resetCycleLength, daysUntilReset: daysUntilReset, maxCredits: maxCredits, currentCredits: currentCredits)
        
        // refresh the view
        tableView.reloadData()
    }
    
    
    /// Sets the height of the table cells.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    { return 120 }
    
    
    /// Sets the number of rows in the table view (should be equal to the # of entries in the data).
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    { return Controller.getCellDataContainerEntityCount()! }
    
    
    // CONFIGURE SWIPE ACTIONS FOR TABLE CELLS
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let delete = deleteAction(indexPath: indexPath)
        let edit = editAction(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
    
    
    /// Configure the 'delete' action for table view cells.
    func deleteAction(indexPath: IndexPath) -> UIContextualAction
    {
        // define action
        let action = UIContextualAction(style: .normal, title: "Remove")
        { (action, view, completion) in
            Controller.removeCell(cellIndex: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        // set properties
        action.backgroundColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        
        return action
    }
    
    
    func editAction(indexPath: IndexPath) -> UIContextualAction
    {
        // define action
        let action = UIContextualAction(style: .normal, title: "Edit")
        { (action, view, completion) in
            // remove current entry
            Controller.removeCell(cellIndex: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            // present edit view
            let editView = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc : UIViewController = editView.instantiateViewController(withIdentifier: "addViewController") as UIViewController
            self.present(vc, animated: true, completion: nil)
            completion(true)
        }
        
        // set properties
        action.backgroundColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        
        return action
    }
    
    
    /*
    ------------------------------
    SYSTEM CONFIGURATION FUNCTIONS
    ------------------------------
    */
    
    
    /// Sets the style of status bar (light/dark).
    override var preferredStatusBarStyle: UIStatusBarStyle
    { return .lightContent }
    
    
    /*
    -----------------------------
    THEME CONFIGURATION FUNCTIONS
    -----------------------------
    */
    
    
    /// Style the view with colors from the current theme.
    func configureViewColors()
    {
        // configure table view
        tableView.backgroundColor = ThemeManager.getCurrentThemeColor(isBGColor: true)
        
        // configure header
        let smallTitleAttributes = [NSAttributedString.Key.foregroundColor: ThemeManager.getCurrentThemeColor(isBGColor: false),
                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.black)]
        let largeTitleAttributes = [NSAttributedString.Key.foregroundColor: ThemeManager.getCurrentThemeColor(isBGColor: false),
                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 35.0, weight: UIFont.Weight.black)]
        navigationController?.navigationBar.titleTextAttributes = smallTitleAttributes as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.largeTitleTextAttributes = largeTitleAttributes as [NSAttributedString.Key : Any]
        
        // configure bar buttons
        settingsButton.tintColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        addButton.tintColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        
        // configure bar buttons
        navigationController?.navigationBar.barTintColor = ThemeManager.getCurrentThemeColor(isBGColor: true)
        navigationController?.navigationBar.tintColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        
        // configure navigation bar
        navigationController?.navigationBar.barTintColor = ThemeManager.getCurrentThemeColor(isBGColor: true)
        navigationController?.navigationBar.tintColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
    }
}

