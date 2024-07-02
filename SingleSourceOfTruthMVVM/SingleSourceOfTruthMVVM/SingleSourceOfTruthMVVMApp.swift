//
//  SingleSourceOfTruthMVVMApp.swift
//  SingleSourceOfTruthMVVM
//
//  Created by Danijel Huis on 02.07.2024..
//

import SwiftUI

@main
struct SingleSourceOfTruthMVVMApp: App {
    @State var navigator = Navigator()
    
    var body: some Scene {
        WindowGroup {
            AppNavigationStack(navigator: navigator) {
                NoteListView(viewModel: .init(manageNotesUseCase: DIContainer.noteManager, coordinator: AppCoordinator(navigator: navigator)))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarBackground(.cyan)
                    .toolbarBackground(.visible, for: .navigationBar)
            }
        }
    }
}
