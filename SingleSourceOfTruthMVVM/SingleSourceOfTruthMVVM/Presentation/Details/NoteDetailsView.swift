//
//  NoteDetailsView.swift
//  SingleSourceOfTruthMVVM
//
//  Created by Danijel Huis on 02.07.2024..
//

import Foundation
import SwiftUI

@MainActor
struct NoteDetailsView: View {
    let viewModel: NoteDetailsViewModel
    
    var body: some View {
        VStack {
            TextField("Text", text: viewModel.note.text)
        }
    }
}
