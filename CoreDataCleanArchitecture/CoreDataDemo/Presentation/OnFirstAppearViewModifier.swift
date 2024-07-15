//
//  OnFirstAppearViewModifier.swift
//
//
//  Created by Danijel Huis on 01.05.2024..
//

import Foundation
import SwiftUI

/// Same as `onAppear` but it is called only once.
struct OnFirstAppearViewModifier: ViewModifier {
    @State private var isFirstAppear = true
    private let onFirstAppear: () -> Void
    
    init(onFirstAppear: @escaping () -> Void) {
        self.onFirstAppear = onFirstAppear
    }
    
    func body(content: Content) -> some View {
        content.onAppear {
            guard isFirstAppear else { return }
            isFirstAppear = false
            onFirstAppear()
        }
    }
}

extension View {
    public func onFirstAppear(_ onFirstAppear: @escaping () -> Void) -> some View {
        modifier(OnFirstAppearViewModifier(onFirstAppear: onFirstAppear))
    }
}
