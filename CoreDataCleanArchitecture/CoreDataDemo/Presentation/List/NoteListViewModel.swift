//
//  NoteListViewModel.swift
//  CoreDataDemo
//
//  Created by Danijel Huis on 13.07.2024..
//

import Foundation

@MainActor @Observable
final class NoteListViewModel {
    // Dependencies
    let manageNotesUseCase: ManageNotesUseCase
    let coordinator: Coordinator
    
    init(manageNotesUseCase: ManageNotesUseCase, coordinator: Coordinator) {
        self.manageNotesUseCase = manageNotesUseCase
        self.coordinator = coordinator
    }
    
    func addNewNote() {
        Task {
            let newNote = Note(id: UUID().uuidString, title: "new note", text: nil, status: .active)
            try? await manageNotesUseCase.addOrEditNote(note: newNote)
        }
    }
    
    func deleteAllNotes() {
        Task {
            try? await manageNotesUseCase.deleteAllNotes()
        }
    }
    
    func didSelectItem(id: String) {
        guard let note = manageNotesUseCase.notes.first(where: { $0.id == id }) else { return }
        coordinator.openRoute(.editNote(note: note))
    }
    
    func onFirstAppear() {
        Task {
            try await getItems()
        }
    }
    
    private func getItems() async throws {
        try await manageNotesUseCase.getNotes()
    }
    
    // MARK: - View State -
    
    let navigationTitle = "Notes"
    var items: [NoteListItem] {
        let items = manageNotesUseCase.notes.map({ NoteListItem(id: $0.id, name: $0.title) })
        return items
    }
}

struct NoteListItem: Identifiable {
    let id: String
    let name: String
}


