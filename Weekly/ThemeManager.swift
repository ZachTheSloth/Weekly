//
//  ThemeManager.swift
//  Weekly
//
//  Created by Zachary Williams on 8/6/18.
//  Copyright © 2018 Zachary Williams. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ThemeManager
{
    
    
    
    // Core Data
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static var context = appDelegate.persistentContainer.viewContext
    
    
    // Dictionary of theme names and corrosponding colors.
    private static var themeLibrary =
        [ "Gum"         : [UIColor(red:0.98, green:0.58, blue:0.59, alpha:1.0), UIColor(red:0.13, green:0.24, blue:0.56, alpha:1.0)],
          "Rich Red"    : [UIColor(red:0.84, green:0.28, blue:0.25, alpha:1.0), UIColor(red:0.04, green:0.03, blue:0.02, alpha:1.0)],
          "Terminal"    : [UIColor(red:0.09, green:0.31, blue:0.26, alpha:1.0), UIColor(red:0.55, green:0.81, blue:0.65, alpha:1.0)],
          "Blueprint"   : [UIColor(red:0.98, green:0.98, blue:0.95, alpha:1.0), UIColor(red:0.22, green:0.47, blue:0.60, alpha:1.0)],
          "Mint"        : [UIColor(red:0.75, green:0.99, blue:0.76, alpha:1.0), UIColor(red:0.54, green:0.36, blue:0.33, alpha:1.0)],
          "Carrot"      : [UIColor(red:0.14, green:0.16, blue:0.27, alpha:1.0), UIColor(red:0.85, green:0.56, blue:0.24, alpha:1.0)],
          "Blue Night"  : [UIColor(red:0.14, green:0.05, blue:0.02, alpha:1.0), UIColor(red:0.06, green:0.69, blue:0.64, alpha:1.0)],
          "Plum"        : [UIColor(red:0.93, green:0.78, blue:0.33, alpha:1.0), UIColor(red:0.40, green:0.23, blue:0.44, alpha:1.0)]]
    
    
    
    
    public static func getTheme(themeName: String, isInverted: Bool) -> [UIColor]
    {
        if isInverted // Swap the color order.
        {
            var theme = themeLibrary[themeName]!
            let temp = theme[0]
            theme[0] = theme[1]
            theme[1] = temp
            return theme
        }
        return themeLibrary[themeName]!
    }
    
    
    
    
    public static func getCurrentThemeColor(isBGColor: Bool) -> UIColor?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrentThemeContainer")
        do
        {
            let result = try context.fetch(request) as! [NSManagedObject]
            let themeName = result[0].value(forKey: "themeName") as! String
            let isInverted = result[0].value(forKey: "isInverted") as! Bool
            if isBGColor
            { return getTheme(themeName: themeName, isInverted: isInverted)[0] }
            else
            { return getTheme(themeName: themeName, isInverted: isInverted)[1] }
        }
        catch
        {
            print("getCurrentThemeBGColor() fetch request failed.")
            return nil
        }
    }
    
    
    
    
    public static func setCurrentTheme(themeName: String, isInverted: Bool)
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrentThemeContainer")
        do
        {
            // Get the theme container.
            let result = try context.fetch(request) as! [NSManagedObject]
            
            // Delete the container.
            if result.count > 0
            { context.delete(result[0]) }
            
            // Create a new theme container.
            let entity = NSEntityDescription.entity(forEntityName: "CurrentThemeContainer", in: context)
            let newCurrentThemeContainer = NSManagedObject(entity: entity!, insertInto: context)
            
            // Set up new theme container attributes.
            newCurrentThemeContainer.setValue(themeName, forKey: "themeName")
            newCurrentThemeContainer.setValue(isInverted, forKey: "isInverted")
            
            // Save changes.
            try context.save()
        }
        catch
        {
            print("setCurrentTheme fetch request failed.")
        }
    }
    
    
    
}
