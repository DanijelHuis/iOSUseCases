//
//  NoteListView.swift
//  CoreDataDemo
//
//  Created by Danijel Huis on 13.07.2024..
//

import SwiftUI

@MainActor struct NoteListView: View {
    let viewModel: NoteListViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.items) { item in
                    Text(item.name)
                        .listRowSeparator(.hidden, edges: .all)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            viewModel.didSelectItem(id: item.id)
                        }
                }
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .toolbar {
            ToolbarItem {
                Button {
                    viewModel.addNewNote()
                } label: {
                    Image(systemName: "plus.app")
                }
            }
            
            ToolbarItem {
                Button {
                    viewModel.deleteAllNotes()
                } label: {
                    Image(systemName: "xmark.square")
                }
            }
        }
        .onFirstAppear {
            viewModel.onFirstAppear()
        }
    }
}
