//
//  ViewControllerExtensions.swift
//  mapix
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 01/10/16.
//  Copyright © 2016 OC. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    
    var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as? AppDelegate)?
                .persistentContainer.viewContext
    }
    
}
