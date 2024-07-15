//
//  NSManagedObject+Convenience.swift
//  CoreDataDemo
//
//  Created by Danijel Huis on 13.07.2024..
//

import Foundation
import CoreData

extension NSManagedObject {
    
    // MARK: - Create -
    
    /// Creates new object.
    static func createNewObject(context: NSManagedObjectContext) -> Self {
        Self(context: context)
    }
    
    // MARK: - Get -
    
    /// Gets existing object from the database.
    /// - Parameter returnsObjectsAsFaults:    Set it to true if you know you will need (get) all/most properties. It improves performance significantly. If this is false then separate request to database is needed for every property get.
    static func getExistingObjects<T>(type: T.Type, context: NSManagedObjectContext, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]? = nil, fetchLimit: Int? = nil, returnsObjectsAsFaults: Bool = true) throws -> [T] where T: NSFetchRequestResult {
        let fetchRequest = NSFetchRequest<T>()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: NSStringFromClass(T.self), in: context)
        fetchRequest.predicate = predicate
        fetchRequest.returnsObjectsAsFaults = returnsObjectsAsFaults
        if let sortDescriptors { fetchRequest.sortDescriptors = sortDescriptors }
        if let fetchLimit { fetchRequest.fetchLimit = fetchLimit }
        return try context.fetch(fetchRequest)
    }
    
    /// Same as getExistingObjects but returns only first object.
    static func getExistingObject(context: NSManagedObjectContext, predicate: NSPredicate?, returnsObjectsAsFaults: Bool = true) throws -> Self? {
        try getExistingObjects(type: Self.self,
                               context: context,
                               predicate: predicate,
                               fetchLimit: 1,
                               returnsObjectsAsFaults: returnsObjectsAsFaults).first
    }
    
    /// Returns existing object or creates new one if it doesn't exist.
    static func getExistingObjectOrCreateNew(context: NSManagedObjectContext, predicate: NSPredicate?, returnsObjectsAsFaults: Bool = true) throws -> Self {
        let firstObject: Self? = try getExistingObjects(type: Self.self,
                                                        context: context,
                                                        predicate: predicate,
                                                        fetchLimit: 1,
                                                        returnsObjectsAsFaults: returnsObjectsAsFaults).first
        return firstObject ?? createNewObject(context: context)
    }
}

