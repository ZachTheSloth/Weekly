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
    
    
    
    override func viewDidLoad()
    {
        configureView()
    }
    
    
    
    
    // CONFIGURATION METHODS
    
    
    // Style of status bar (light/dark).
    override var preferredStatusBarStyle: UIStatusBarStyle
    { return .lightContent }
    
    
    // Configure the view's visual settings.
    func configureView()
    { self.view.backgroundColor = ThemeManager.getCurrentThemeColor(isBGColor: true) }
    
    
    
}
