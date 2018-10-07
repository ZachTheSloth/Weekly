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
    
    
    override func viewDidLoad()
    {
        configureView()
        configureHeader()
        configureNavBar()
        
        // Update info displayed in table.
        tableView.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        configureView()
        configureHeader()
        configureNavBar()
        
        // Update info displayed in table.
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = Bundle.main.loadNibNamed("ThemeCell", owner: self, options: nil)?.first as! ThemeCell
        
        let themeName = ThemeManager.getThemeByIndex(index: indexPath.row)
        print(themeName)
        
        let foregroundColor = ThemeManager.getTheme(themeName: themeName, isInverted: false)[0]
        let backgroundColor = ThemeManager.getTheme(themeName: themeName, isInverted: false)[1]
        
        // Set the background & selection color of the entire cell.
        let bgColorView = UIView()
        bgColorView.backgroundColor = backgroundColor
        cell.backgroundColor = backgroundColor
        cell.selectedBackgroundView = bgColorView
        
        // Set up the text and color for the title.
        cell.nameLabel.text = themeName
        cell.nameLabel.textColor = foregroundColor
        
        // Set the selection image:
        cell.selectionImage.image = UIImage(named: "credit_empty")
        cell.selectionImage.setImageColor(color: foregroundColor)
        
        tableView.reloadData()
        
        return cell
    }
    
    
    // Configuration methods
    
    
    // Sets the height of the table cells.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    { return 80 }
    
    
    // Sets the number of rows in the table view (should be equal to the # of entries in the data).
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    { return ThemeManager.getThemeCount() }
    
    
    // Style of status bar (light/dark).
    override var preferredStatusBarStyle: UIStatusBarStyle
    { return .lightContent }
    
    
    // Configure the view's visuals
    func configureView()
    { self.view.backgroundColor = ThemeManager.getCurrentThemeColor(isBGColor: true) }
    
    
    // Style the title text color.
    func configureHeader()
    {
        let textAttributes = [NSAttributedString.Key.foregroundColor: ThemeManager.getCurrentThemeColor(isBGColor: false)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
    }
    
    
    // Configure nav bar background color, as well as default text color.
    func configureNavBar()
    {
        navigationController?.navigationBar.barTintColor = ThemeManager.getCurrentThemeColor(isBGColor: true)
        navigationController?.navigationBar.tintColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
    }
    
    
}
