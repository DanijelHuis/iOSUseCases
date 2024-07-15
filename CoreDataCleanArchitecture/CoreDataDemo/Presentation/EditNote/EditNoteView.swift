//
//  EditNoteView.swift
//  CoreDataDemo
//
//  Created by Danijel Huis on 13.07.2024..
//

import SwiftUI

@MainActor struct EditNoteView: View {
    @Bindable var viewModel: EditNoteViewModel
    
    var body: some View {
        VStack {
            TextField(viewModel.titlePlaceholder, text: $viewModel.note.title)
            Spacer()
        }
        .padding(20)
        .navigationTitle(viewModel.navigationTitle)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    viewModel.save()
                } label: {
                    Text("Save")
                }
            }
        }
    }
}


