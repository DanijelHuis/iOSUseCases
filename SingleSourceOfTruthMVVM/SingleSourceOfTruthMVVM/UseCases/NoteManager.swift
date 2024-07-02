//
//  NoteManager.swift
//  SingleSourceOfTruthMVVM
//
//  Created by Danijel Huis on 02.07.2024..
//

import Foundation

@MainActor @Observable
final class NoteManager {
    // Dependencies
    private let noteRepository: NoteRepository
    // Private
    var notes = [Note]()
    
    init(noteRepository: NoteRepository) {
        self.noteRepository = noteRepository
    }
    
    func getNotes() async throws {
        notes = try await noteRepository.getNotes()
    }
        
    func addNote(_ note: Note) async throws {
        notes = try await noteRepository.addNote(note)
    }
    
    func removeNote(_ id: String) async throws {
        notes = try await noteRepository.removeNote(id)
    }
    
    func updateNote(_ note: Note) async throws {
        notes = try await noteRepository.addNote(note)
    }

}
