//
//  CoreDataObjectProtocol.swift
//  mapix
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 01/10/16.
//  Copyright © 2016 OC. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataObject {
    
    static func retrieve(at context: NSManagedObjectContext,
                         with predicate: NSPredicate?) -> [Self]
    static func createNew(at context: NSManagedObjectContext) -> Self?
    
    static var entityName: String { get }
    static func entityFetchRequest() -> NSFetchRequest<NSManagedObject>
    
}

extension CoreDataObject where Self: NSManagedObject {
    
    static func retrieve(at context: NSManagedObjectContext,
                  with predicate: NSPredicate? = nil) -> [Self] {
        
        let request = entityFetchRequest()
        if let predicate = predicate {
            request.predicate = predicate
        }
        
        do {
            let result = try context.fetch(request)
            return result as! [Self]
        } catch {
            // TODO: handle error
            return []
        }
    }
    
    static func createNew(at context: NSManagedObjectContext) -> Self? {
        if let entity = NSEntityDescription
            .insertNewObject(forEntityName: entityName,
                             into: context) as? Self {
            return entity
        }
        return nil
    }
    
}
