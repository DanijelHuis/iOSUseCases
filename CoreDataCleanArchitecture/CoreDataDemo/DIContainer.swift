//
//  DIContainer.swift
//  CoreDataDemo
//
//  Created by Danijel Huis on 12.07.2024..
//

import Foundation

enum DIContainer {
    @MainActor static var coreDataNoteRepository: CoreDataNoteDataSource {
        CoreDataNoteDataSource(container: cdManager.container)
    }
    @MainActor static var noteManager = NoteManager(noteRepository: coreDataNoteRepository)
    @MainActor static let cdManager = CoreDataManager(name: "CoreDataDemo")
}
