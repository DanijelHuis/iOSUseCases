//
//  NoteListView.swift
//  SingleSourceOfTruthMVVM
//
//  Created by Danijel Huis on 02.07.2024..
//

import SwiftUI

@MainActor
struct NoteListView: View {
    let viewModel: NoteListViewModel
    
    var body: some View {
        // @TODO handle view status
        List {
            ForEach(viewModel.listItems) { item in
                Text(item.text)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.openNote(item)
                    }
            }
        }
        .navigationTitle(viewModel.title)
        .toolbar {
            Button {
                viewModel.addNote(.init(text: "New note"))
            } label: {
                Image(systemName: "plus.app")
            }
            .accessibilityIdentifier("list_add")
        }
        .onFirstAppear {
            viewModel.onFirstAppear()
        }
    }
}

/*
#Preview {
    NoteListView(viewModel: .init(manageNotesUseCase: NoteManager(noteRepository: LocalNoteDataSource())))
}*/
