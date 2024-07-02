//
//  DIContainer.swift
//  SingleSourceOfTruthMVVM
//
//  Created by Danijel Huis on 02.07.2024..
//

import Foundation

final class DIContainer {
    static var noteRepository: NoteRepository {
        LocalNoteDataSource()
    }
    
    @MainActor
    static var noteManager: NoteManager {
        NoteManager(noteRepository: noteRepository)
    }
}
