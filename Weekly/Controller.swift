//
//  Controller.swift
//  Weekly
//
//  Created by Zachary Williams on 8/5/18.
//  Copyright © 2018 Zachary Williams. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Controller
{
    

    // Core Data
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static var context = appDelegate.persistentContainer.viewContext
    
    
    init()
    {}
    
    
    // METHODS FOR RETRIEVING CELL DATA
    
    
    static private func getCellData(cellIndex: Int) -> NSManagedObject?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CellDataContainer")
        do
        {
            let result = try context.fetch(request) as! [NSManagedObject]
            return result[cellIndex]
        }
        catch
        {
            print("getCellData() fetch request failed.")
            return nil
        }
    }
    
    
    static func getCellDataContainerEntityCount() -> Int?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CellDataContainer")
        do
        {
            let result = try context.fetch(request) as! [NSManagedObject]
            return result.count
        }
        catch
        {
            print("getCellDataContainerEntityCount() fetch request failed.")
            return nil
        }
    }
    
    
    static func getCellTitle(cellIndex: Int) -> String
    {
        let cellDataContainer = getCellData(cellIndex: cellIndex)
        return cellDataContainer?.value(forKey: "title") as! String
    }
    
    
    static func getCellResetCycleLength(cellIndex: Int) -> Int
    {
        let cellDataContainer = getCellData(cellIndex: cellIndex)
        return cellDataContainer?.value(forKey: "resetCycleLength") as! Int
    }
    
    
    static func getCellDaysUntilReset(cellIndex: Int) -> Int
    {
        let cellDataContainer = getCellData(cellIndex: cellIndex)
        return cellDataContainer?.value(forKey: "daysUntilReset") as! Int
    }
    
    
    static func getCellMaxCredits(cellIndex: Int) -> Int
    {
        let cellDataContainer = getCellData(cellIndex: cellIndex)
        return cellDataContainer?.value(forKey: "maxCredits") as! Int
    }
    
    
    static func getCellCurrentCredits(cellIndex: Int) -> Int
    {
        let cellDataContainer = getCellData(cellIndex: cellIndex)
        return cellDataContainer?.value(forKey: "currentCredits") as! Int
    }
    
    
    // Creating/Removing Item Cells
    
    
    static func createCell(title: String, resetCycleLength: Int, maxCredits: Int)
    {
        // Create the new entity and CellDataContainer.
        let entity = NSEntityDescription.entity(forEntityName: "CellDataContainer", in: context)
        let newCellDataContainer = NSManagedObject(entity: entity!, insertInto: context)
        
        // Set up their attributes.
        newCellDataContainer.setValue(title, forKey: "title")
        newCellDataContainer.setValue(resetCycleLength, forKey: "resetCycleLength")
        newCellDataContainer.setValue(resetCycleLength, forKey: "daysUntilReset")
        newCellDataContainer.setValue(maxCredits, forKey: "maxCredits")
        newCellDataContainer.setValue(maxCredits, forKey: "currentCredits")
        
        // Save the data.
        saveData()
    }
    
    
    static func updateCell(index: Int, title: String, resetCycleLength: Int, daysUntilReset: Int, maxCredits: Int, currentCredits: Int)
    {
        // Get NSManagedObject refrence.
        let cell = getCellData(cellIndex: index)
        
        // Set appropriate data.
        cell?.setValue(title, forKey: "title")
        cell?.setValue(resetCycleLength, forKey: "resetCycleLength")
        cell?.setValue(daysUntilReset, forKey: "daysUntilReset")
        cell?.setValue(maxCredits, forKey: "maxCredits")
        cell?.setValue(currentCredits, forKey: "currentCredits")
        
        // Save model.
        saveData()
    }
    
    
    static func removeCell(cellIndex: Int)
    {
        context.delete(getCellData(cellIndex: cellIndex)!)
        saveData()
    }
    
    
    static func saveData()
    {
        do
        { try context.save() }
        catch
        { print("Failed to save data context.") }
    }
    
    
}
