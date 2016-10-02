//
//  Picture+CoreDataClass.swift
//  mapix
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 01/10/16.
//  Copyright © 2016 OC. All rights reserved.
//

import Foundation
import CoreData


public class Picture: NSManagedObject {

    static var entityName = "Picture"
    
    static func entityFetchRequest() -> NSFetchRequest<NSManagedObject> {
        let request: NSFetchRequest<Picture> = NSFetchRequest(entityName: entityName)
        return request as! NSFetchRequest<NSManagedObject>
    }
    
    static func retrieve(at context: NSManagedObjectContext,
                         with predicate: NSPredicate? = nil) -> [Picture] {
        
        let request: NSFetchRequest<Picture> = NSFetchRequest(entityName: entityName)
        if let predicate = predicate {
            request.predicate = predicate
        }
        
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            // TODO: handle error
            return []
        }
    }
    
    static func createNew(at context: NSManagedObjectContext) -> Picture? {
        if let entity = NSEntityDescription
            .insertNewObject(forEntityName: entityName,
                             into: context) as? Picture {
            return entity
        }
        return nil
    }
    
}
