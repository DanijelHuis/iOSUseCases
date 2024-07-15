//
//  EditNoteViewModel.swift
//  CoreDataDemo
//
//  Created by Danijel Huis on 14.07.2024..
//

import Foundation

@MainActor @Observable
final class EditNoteViewModel {
    private let addOrEditNoteUseCase: AddOrEditNoteUseCase
    var note: Note
    var onFinished: (() -> Void)?
    
    init(note: Note, addOrEditNoteUseCase: AddOrEditNoteUseCase) {
        self.note = note
        self.addOrEditNoteUseCase = addOrEditNoteUseCase
    }
    
    func save() {
        Task {
            try await addOrEditNoteUseCase.addOrEditNote(note:note)
            onFinished?()
        }
    }
    
    // MARK: - View state -
    
    let navigationTitle = "Edit"
    let titlePlaceholder = "Note title"
}
