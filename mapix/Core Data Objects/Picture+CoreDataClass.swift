//
//  Picture+CoreDataClass.swift
//  mapix
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 01/10/16.
//  Copyright © 2016 OC. All rights reserved.
//

import Foundation
import CoreData


final public class Picture: NSManagedObject, CoreDataObject {

    static var entityName = "Picture"
    
    static func entityFetchRequest<T : NSManagedObject>() -> NSFetchRequest<T> {
        let request: NSFetchRequest<Picture> = NSFetchRequest(entityName: entityName)
        return request as! NSFetchRequest<T>
    }
    
}
