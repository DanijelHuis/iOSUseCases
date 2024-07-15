//
//  Note.swift
//  CoreDataDemo
//
//  Created by Danijel Huis on 12.07.2024..
//

import Foundation

public struct Note: Sendable {
    public var id: String
    public var title: String
    public var text: String?
    public var status: NoteStatus
}
