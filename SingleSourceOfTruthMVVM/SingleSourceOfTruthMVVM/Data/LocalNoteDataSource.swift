//
//  LocalNoteDataSource.swift
//  SingleSourceOfTruthMVVM
//
//  Created by Danijel Huis on 02.07.2024..
//

import Foundation

/// Implementing Repository protocol directly on data source since they have same signatures (I use domain entities in data source).
actor LocalNoteDataSource: NoteRepository {
    private var notes = [Note]()
    
    func getNotes() async throws -> [Note] {
        notes
    }
    
    func addNote(_ note: Note) async throws -> [Note] {
        notes.insert(note, at: 0)
        return notes
    }
    
    func removeNote(_ id: String) async throws -> [Note] {
        notes = notes.filter({ $0.id != id })
        return notes
    }
    
    func updateNote(_ note: Note) async throws -> [Note] {
        guard let index = notes.firstIndex(where: { $0.id == note.id }) else { throw NoteRepositoryError.noteNotFound }
        notes[index] = note
        return notes
    }
}
