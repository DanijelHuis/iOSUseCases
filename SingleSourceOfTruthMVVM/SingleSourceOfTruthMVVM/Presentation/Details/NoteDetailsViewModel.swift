//
//  NoteDetailsViewModel.swift
//  SingleSourceOfTruthMVVM
//
//  Created by Danijel Huis on 02.07.2024..
//

import Foundation
import SwiftUI

@MainActor @Observable
final class NoteDetailsViewModel {
    var note: Binding<Note>
    
    init(note: Binding<Note>) {
        self.note = note
    }
}
