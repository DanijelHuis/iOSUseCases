//
//  CoreDataNoteDataSource.swift
//  CoreDataDemo
//
//  Created by Danijel Huis on 12.07.2024..
//

import Foundation
import CoreData

/// We are conforming dataSource directly to repository protocol just to skip steps since we don't need extra logic in repository in this case.
final class CoreDataNoteDataSource: NoteRepository {
    private let container: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    // MARK: - Get -
    
    func getNotes(filters: [NoteFilter]) async throws -> [Note] {
        return try await container.performSerial(save: false) { context in
            let movieObjects = try NSManagedObject.getExistingObjects(type: NoteObject.self,
                                                                      context: context,
                                                                      predicate: self.predicate(filters: filters))
            return movieObjects.compactMap({ $0.mapped() })
        }
    }
    
    // MARK: - Add -
    
    func addOrEditNote(note: Note) async throws {
        return try await container.performSerial(save: true)  { context in
            let predicate = NSPredicate(format: "noteID == %@", note.id)
            let noteObject = try NoteObject.getExistingObjectOrCreateNew(context: context,
                                                                         predicate: predicate)
            noteObject.copy(note: note)
        }
    }
    
    // MARK: - Delete -
    
    func deleteAllNotes() async throws {
        return try await container.performSerial(save: true)  { context in
            let movieObjects = try NSManagedObject.getExistingObjects(type: NoteObject.self,
                                                                      context: context,
                                                                      predicate: nil)
            movieObjects.forEach({ context.delete($0) })
        }
    }
    
    // MARK: - Utility -
    
    private func predicate(filters: [NoteFilter]) -> NSPredicate? {
        return nil
    }
}

// MARK: - Data <-> Domain mapping -

private extension NoteObject {
    func mapped() -> Note? {
        guard let noteID, let title, let status else { return nil }
        return .init(id: noteID, title: title, text: text, status: .init(rawValue: status) ?? .active)
    }
    
    func copy(note: Note) {
        self.noteID = note.id
        self.title = note.title
        self.text = note.text
        self.status = note.status.rawValue
    }
}


