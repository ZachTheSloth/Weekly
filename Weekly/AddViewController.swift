//
//  AddViewController.swift
//  Weekly
//
//  Created by Zachary Williams on 8/6/18.
//  Copyright © 2018 Zachary Williams. All rights reserved.
//

import UIKit

class AddViewController : UIViewController
{
    
    
    
    @IBOutlet weak var titleTextBox: UITextField!
    @IBOutlet weak var creditExpirationSelectionTitle: UILabel!
    @IBOutlet weak var creditExpirationSelector: UISegmentedControl!
    @IBOutlet weak var creditsSelectorTitle: UILabel!
    @IBOutlet weak var creditsSelector: UISegmentedControl!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    
    override func viewDidLoad()
    {
        configureView()
        configureUIElements()
    }
    
    
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton)
    {
        // Get attributes from UI elements.
        let title = titleTextBox.text
        let expiration = creditExpirationSelector.selectedSegmentIndex + 1
        let maxCredits = creditsSelector.selectedSegmentIndex + 1
        
        // Add a new cell in the model.
        Controller.createCell(title: title!, resetCycleLength: expiration, maxCredits: maxCredits)
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    
    // CONFIGURATION METHODS
    
    
    // Style of status bar (light/dark).
    override var preferredStatusBarStyle: UIStatusBarStyle
    { return .lightContent }
    
    
    // Configure the view's visual settings.
    func configureView()
    { self.view.backgroundColor = ThemeManager.getCurrentThemeColor(isBGColor: true) }
    
    
    // Configure colors of all UI elements.
    func configureUIElements()
    {
        // Set up title text box.
        titleTextBox.textColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        titleTextBox.tintColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        titleTextBox.backgroundColor = ThemeManager.getCurrentThemeColor(isBGColor: true)
        titleTextBox.layer.borderColor = ThemeManager.getCurrentThemeColor(isBGColor: false)?.cgColor
        titleTextBox.layer.borderWidth = 4
        
        // Set BOTH selector header lables.
        creditExpirationSelectionTitle.textColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        creditsSelectorTitle.textColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        
        // Set up custom font for selectors.
        let font = UIFont.systemFont(ofSize: 20, weight: .black)
        
        // Configure the credit expiration selector.
        creditExpirationSelector.tintColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        creditExpirationSelector.layer.borderColor = ThemeManager.getCurrentThemeColor(isBGColor: false)?.cgColor
        creditExpirationSelector.layer.borderWidth = 4
        creditExpirationSelector.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        creditExpirationSelector.setDividerImage(UIImage(named: "invisible_line"), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: UIBarMetrics.default)
        
        // Configure the credit selector.
        creditsSelector.tintColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        creditsSelector.layer.borderColor = ThemeManager.getCurrentThemeColor(isBGColor: false)?.cgColor
        creditsSelector.layer.borderWidth = 4
        creditsSelector.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        creditsSelector.setDividerImage(UIImage(named: "invisible_line"), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: UIBarMetrics.default)
        
        // Customize the save button.
        saveButton.tintColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
    }
    
    
    
}
