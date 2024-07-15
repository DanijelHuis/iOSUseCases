//
//  NoteRepository.swift
//  CoreDataDemo
//
//  Created by Danijel Huis on 14.07.2024..
//

import Foundation

protocol NoteRepository: Sendable {
    func getNotes(filters: [NoteFilter]) async throws -> [Note]
    func addOrEditNote(note: Note) async throws
    func deleteAllNotes() async throws
}
