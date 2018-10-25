//
//  AddViewController.swift
//  Weekly
//
//  Created by Zachary Williams on 8/6/18.
//  Copyright © 2018 Zachary Williams. All rights reserved.
//

import UIKit

class AddViewController : UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var titleTextBox: UITextField!
    @IBOutlet weak var creditExpirationSelectionTitle: UILabel!
    @IBOutlet weak var creditExpirationSelector: UISegmentedControl!
    @IBOutlet weak var creditsSelectorTitle: UILabel!
    @IBOutlet weak var creditsSelector: UISegmentedControl!
    @IBOutlet weak var saveButton: UIButton!
    
    
    /*
    -------------------
    BUTTON INTERACTIONS
    -------------------
    */
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton)
    {
        // get attributes from UI elements
        let title = titleTextBox.text
        let expiration = creditExpirationSelector.selectedSegmentIndex + 1
        let maxCredits = creditsSelector.selectedSegmentIndex + 1
        
        // add a new cell in the model
        Controller.createCell(title: title!, resetCycleLength: expiration, maxCredits: maxCredits)
        navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    -----------------------------
    VIEW INITIALIZATION FUNCTIONS
    -----------------------------
    */
    
    
    override func viewDidLoad()
    {
        // this allows the keyboard to be hidden by this class
        titleTextBox.delegate = self
        
        // configuration
        configureViewColors()
        configureKeyboard()
    }
    

    override func viewWillAppear(_ animated: Bool)
    { configureViewColors() }
    
    
    override func viewDidAppear(_ animated: Bool)
    { configureViewColors() }
    
    
    /*
    ------------------------------
    SYSTEM CONFIGURATION FUNCTIONS
    ------------------------------
    */
    
    
    /// This will hide the keyboard when the 'done' button is pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
    
    /// Set the style of status bar (light/dark).
    override var preferredStatusBarStyle: UIStatusBarStyle
    { return .lightContent }
    
    
    /// Configure keyboard behavior.
    func configureKeyboard()
    {
        // keyboard autohide when view tapped
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    
    /*
    -----------------------------
    THEME CONFIGURATION FUNCTIONS
    -----------------------------
    */
    
    
    /// Style the view with colors from the current theme.
    func configureViewColors()
    {
        // configure the view
        self.view.backgroundColor = ThemeManager.getCurrentThemeColor(isBGColor: true)
        
        // configure the title text box
        titleTextBox.textColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        titleTextBox.tintColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        titleTextBox.backgroundColor = ThemeManager.getCurrentThemeColor(isBGColor: true)
        titleTextBox.layer.borderColor = ThemeManager.getCurrentThemeColor(isBGColor: false)?.cgColor
        titleTextBox.layer.borderWidth = 4
        
        // set both selector header labels
        creditExpirationSelectionTitle.textColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        creditsSelectorTitle.textColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        
        // set up custom selector font
        let font = UIFont.systemFont(ofSize: 20, weight: .black)
        
        // configure the credit expiration selector
        creditExpirationSelector.tintColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        creditExpirationSelector.layer.borderColor = ThemeManager.getCurrentThemeColor(isBGColor: false)?.cgColor
        creditExpirationSelector.layer.borderWidth = 4
        creditExpirationSelector.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        creditExpirationSelector.setDividerImage(UIImage(named: "invisible_line"), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: UIBarMetrics.default)
        
        // configure the credit selector
        creditsSelector.tintColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
        creditsSelector.layer.borderColor = ThemeManager.getCurrentThemeColor(isBGColor: false)?.cgColor
        creditsSelector.layer.borderWidth = 4
        creditsSelector.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        creditsSelector.setDividerImage(UIImage(named: "invisible_line"), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: UIBarMetrics.default)
        
        // customize the save button
        saveButton.tintColor = ThemeManager.getCurrentThemeColor(isBGColor: false)
    }
}
