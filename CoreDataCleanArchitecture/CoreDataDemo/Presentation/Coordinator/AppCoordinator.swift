//
//  AppCoordinator.swift
//  SwiftUIDemo
//
//  Created by Danijel Huis on 01.07.2024..
//

import Foundation
import SwiftUI
// MARK: - Main App Coordinator -

@MainActor public protocol Coordinator {
    func openRoute(_ route: AppRoute)
}

@MainActor
struct AppCoordinator: Coordinator {
    let navigator: Navigator
    
    init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    func openRoute(_ route: AppRoute) {
        navigator.push(route, view: destination(route))
    }

    @ViewBuilder
    private func destination(_ route: AppRoute) -> some View {
        switch route {
        case .editNote(let note):
            let viewModel = EditNoteViewModel(note: note, addOrEditNoteUseCase: DIContainer.noteManager)
            let _ = viewModel.onFinished = {
                navigator.pop()
            }
            EditNoteView(viewModel: viewModel)
        }
    }

}
