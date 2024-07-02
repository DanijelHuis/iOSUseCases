//
//  AppNavigationStack.swift
//  SwiftUIDemo
//
//  Created by Danijel Huis on 01.07.2024..
//

import Foundation
import SwiftUI

/// NavigationStack that can open any `AppRoute.
public struct AppNavigationStack<Root: View>: View {
    @Bindable private var navigator: Navigator
    private let root: Root
    
    public init(navigator: Navigator, @ViewBuilder root: () -> Root) {
        self.navigator = navigator
        self.root = root()
    }
    
    public var body: some View {
        NavigationStack(path: $navigator.path) {
            root
                .navigationDestination(for: NavigationDestination.self) { destination in
                    return AnyView(destination.view)
                }
        }
    }
}
