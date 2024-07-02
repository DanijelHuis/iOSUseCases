//
//  NoteListViewModel.swift
//  SingleSourceOfTruthMVVM
//
//  Created by Danijel Huis on 02.07.2024..
//

import Foundation
import SwiftUI

@MainActor @Observable
final class NoteListViewModel {
    // @TODO use case
    private let manageNotesUseCase: NoteManager
    private let coordinator: AppCoordinator
    
    init(manageNotesUseCase: NoteManager, coordinator: AppCoordinator) {
        self.manageNotesUseCase = manageNotesUseCase
        self.coordinator = coordinator
    }
    
    func onFirstAppear() {
        Task {
            await getNotes()
        }
    }
    
    func addNote(_ note: Note) {
        Task {
            try await manageNotesUseCase.addNote(note)
        }
    }
    
    func openNote(_ note: NoteListItem) {
        @Bindable var manageNotesUseCase = manageNotesUseCase
        guard let noteBinding = $manageNotesUseCase.notes.first(where: { $0.wrappedValue.id == note.id }) else { return }
        coordinator.openRoute(.noteDetails(note: noteBinding))
    }
    
    private func getNotes() async {
        do {
            status = .loading
            try await manageNotesUseCase.getNotes()
            status = .loaded
        } catch {
            status = .error()
        }
    }
    
    // MARK: - State -
    
    var title = "Notes"
    var status = ViewStatus.idle
    
    var listItems: [NoteListItem] {
        manageNotesUseCase.notes.map({ .init(id: $0.id, text: $0.text) })
    }
}

extension NoteListViewModel {
    enum ViewStatus {
        case idle
        case loading
        case error(text: String = "Error happened")
        case loaded
    }
}

struct NoteListItem: Identifiable, Equatable {
    var id: String
    var text: String
}
