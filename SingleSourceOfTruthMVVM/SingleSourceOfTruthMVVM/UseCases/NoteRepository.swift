//
//  NoteRepository.swift
//  SingleSourceOfTruthMVVM
//
//  Created by Danijel Huis on 02.07.2024..
//

import Foundation

protocol NoteRepository {
    func getNotes() async throws -> [Note]
    func addNote(_ note: Note) async throws -> [Note]
    func removeNote(_ id: String) async throws -> [Note]
    func updateNote(_ note: Note) async throws -> [Note]
}

enum NoteRepositoryError: Error {
    case noteNotFound
}
