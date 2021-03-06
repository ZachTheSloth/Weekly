//
//  SettingsViewController.swift
//  Weekly
//
//  Created by Zachary Williams on 8/11/18.
//  Copyright © 2018 Zachary Williams. All rights reserved.
//

import Foundation
import UIKit

class SettingsTableViewController : UITableViewController
{
    /// Gets a list of themes in a concrete ordering.
    var themes = ThemeManager.getThemesAsOrderedArray()
    
    
    /*
    -----------------------------
    VIEW INITIALIZATION FUNCTIONS
    -----------------------------
    */
    
    
    override func viewDidLoad()
    { configureViewColors() }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        tableView.reloadData()
        configureViewColors()
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    { configureViewColors() }
    
    
    /*
    -----------------------------------------------
    TABLE VIEW CONSTRUCTION/CONFIGURATION FUNCTIONS
    -----------------------------------------------
    */
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = Bundle.main.loadNibNamed("ThemeCell", owner: self, options: nil)?.first as! ThemeCell
        
        let themeName = themes[indexPath.row]
        let foregroundColor = ThemeManager.getTheme(themeName: themeName, isInverted: false)[0]
        let backgroundColor = ThemeManager.getTheme(themeName: themeName, isInverted: false)[1]
        
        // set the background & selection color of the entire cell
        let bgColorView = UIView()
        bgColorView.backgroundColor = backgroundColor
        cell.backgroundColor = backgroundColor
        cell.selectedBackgroundView = bgColorView
        
        // set up the text and color for the title
        cell.nameLabel.text = themeName
        cell.nameLabel.textColor = foregroundColor
        
        // set the selection image
        if themeName == ThemeManager.getCurrentThemeName()
        { cell.selectionImage.image = UIImage(named: "credit_full") }
        else
        { cell.selectionImage.image = UIImage(named: "credit_empty") }
        cell.selectionImage.setImageColor(color: foregroundColor)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        ThemeManager.setCurrentTheme(themeName: themes[indexPath.row], isInverted: false)
        
        // update current view
        configureViewColors()
        tableView.reloadData()
    }
    
    
    /// Sets the height of the table cells.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    { return 80 }
    
    
    /// Sets the number of rows in the table view (should be equal to the # of entries in the data).
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    { return ThemeManager.getThemeCount() }
    
    
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
        // configure view
        self.view.backgroundColor = UIColor.black
        
        // configure header
        let smallTitleAttributes = [NSAttributedString.Key.foregroundColor: ThemeManager.getCurrentThemeColor(isBGColor: false),
                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.black)]
        let largeTitleAttributes = [NSAttributedString.Key.foregroundColor: ThemeManager.getCurrentThemeColor(isBGColor: false),
                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 35.0, weight: UIFont.Weight.black)]
        navigationController?.navigationBar.titleTextAttributes = smallTitleAttributes as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.largeTitleTextAttributes = largeTitleAttributes as [NSAttributedString.Key : Any]
        
        // configure nav bar
        navigationController?.navigationBar.barTintColor = ThemeManager.getCurrentThemeColor(isBGColor: true)
        navigationController?.navigationBar.tintColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
    }
}
