//
//  DataBaseController.swift
//  TodayHealine
//
//  Created by lieon on 2017/3/7.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import Foundation
import CoreData

class DataBaseController {
    private  init () {
        
    }
    
    class func getContext() -> NSManagedObjectContext {
        return DataBaseController.persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
    
        let container = NSPersistentContainer(name: "Data")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    class func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
