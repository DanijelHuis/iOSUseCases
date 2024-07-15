//
//  NoteManager.swift
//  CoreDataDemo
//
//  Created by Danijel Huis on 14.07.2024..
//

import Foundation

// MARK: - Use cases -

@MainActor
protocol ManageNotesUseCase: AddOrEditNoteUseCase {
    var notes: [Note] { get }
    func getNotes() async throws
    func deleteAllNotes() async throws
}

@MainActor
protocol AddOrEditNoteUseCase {
    func addOrEditNote(note: Note) async throws
}

// MARK: - Implementation -

@MainActor @Observable
final class NoteManager: ManageNotesUseCase, AddOrEditNoteUseCase {
    let noteRepository: NoteRepository
    private(set) var filters = [NoteFilter]()
    private(set) var notes = [Note]()
    
    init(noteRepository: NoteRepository) {
        self.noteRepository = noteRepository
        self.notes = notes
    }
    
    func getNotes() async throws {
        self.notes = try await noteRepository.getNotes(filters: filters)
    }
    
    func addOrEditNote(note: Note) async throws {
        try await noteRepository.addOrEditNote(note: note)
        try await getNotes()
    }
    
    func deleteAllNotes() async throws {
        try await noteRepository.deleteAllNotes()
        try await getNotes()
    }
}
