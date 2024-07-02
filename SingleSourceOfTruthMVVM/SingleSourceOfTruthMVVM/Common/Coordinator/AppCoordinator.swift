//
//  AppCoordinator.swift
//  SwiftUIDemo
//
//  Created by Danijel Huis on 01.07.2024..
//

import Foundation
import SwiftUI

@MainActor
struct AppCoordinator {
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
        case .noteDetails(let note):
            let viewModel = NoteDetailsViewModel(note: note)
            NoteDetailsView(viewModel: viewModel)
        }
    }

}
