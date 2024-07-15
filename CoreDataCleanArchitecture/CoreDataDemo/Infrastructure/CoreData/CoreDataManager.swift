//
//  CoreDataManager.swift
//
//
//  Created by Danijel Huis on 12.07.2024..
//

@preconcurrency import CoreData

/// Helper class used to load store and to keep instance of NSPersistentContainer.
final class CoreDataManager: Sendable {
    let container: NSPersistentContainer
    
    init(name: String) {
        // This will fail internally if name is not correct, we are not handling this type of error here (or anywhere).
        container = .init(name: name)
        
        // We won't really use viewContext in clean architecture setup but just to be on the safe side.
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func load() async throws {
        try await container.loadFirstPersistentStore()
    }
}

// MARK: - Support -

extension NSPersistentContainer {
    /// Loads first persistent store. It will wait only for first store to load so make sure to use this only with one-store setup.
    @discardableResult func loadFirstPersistentStore() async throws -> NSPersistentStoreDescription {
        try await withCheckedThrowingContinuation { continuation in
            
            var isFirstPersistentStore = true
            loadPersistentStores(completionHandler: { description, error in
                // Completion handler can be called multiple times, once for each persistent store.
                guard isFirstPersistentStore else { return }
                isFirstPersistentStore = false
                
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: description)
                }
            })
        }
    }
}

// MARK: - performSerial -

extension NSPersistentContainer {
    private static let serialDispatchQueue = DispatchQueue(label: "CoreDataManager")
    
    /// Calls NSPersistentContainer.performBackgroundTask on serial queue. Same serial queue is used for whole app, this makes it safe but could cause performance problems in specific cases.
    /// Why is this needed? So we avoid merge conflicts.
    /// - Parameter save:    if true it will save context after closure is performed.
    func performSerial<T>(save: Bool, _ closure: @escaping (NSManagedObjectContext) throws -> T) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            Self.serialDispatchQueue.asyncUnsafe {
                self.performBackgroundTask { context in
                    do {
                        // Perform closure
                        let returnValue = try closure(context)
                        // Save if needed (this is nice spot to handle save error, e.g. post to analytics).
                        if save {
                            try context.save()
                        }
                        continuation.resume(returning: returnValue)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
}

