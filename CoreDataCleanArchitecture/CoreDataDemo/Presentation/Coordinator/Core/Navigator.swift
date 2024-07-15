//
//  Navigator.swift
//  SwiftUIDemo
//
//  Created by Danijel Huis on 01.07.2024..
//

import Foundation
import SwiftUI

/// Navigator manages navigation path, meaning it is responsible for pushing, popping, presenting etc., similar to UINavigationController. Its path property must be connected to NavigationStack.
@MainActor @Observable
public final class Navigator {
    var path = NavigationPath()
    
    public init() {}
    
    /// Pushes route on navigation path.
    public func push(_ route: AppRoute, view: any View) {
        path.append(NavigationDestination(route: route, view: view))
    }
    
    /// Pops last view from navigation path.
    public func pop() {
        path.removeLast()
    }
    
    /// Presents controller on top presented controller on root. Not ideal but there is no nice way of presenting in SwiftUI without coupling .sheet or .popover inside view hierarchy.
    public func present(_ route: AppRoute, controller: UIViewController, animated: Bool) {
        UIApplication.shared.topPresentedViewController?.present(controller, animated: animated)
    }
}

/// Our goal is to have single .navigationDestination call that can handle all app routes. Since .navigationDestination call takes class type as input that
/// means that we have to make wrapper class that can handle all app routes. Apple obviously didn't intend for NavigationStack to be used like this but it is very convenient.
struct NavigationDestination: Hashable {
    let route: AppRoute
    let view: any View
    
    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        lhs.route.id == rhs.route.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(route.id)
    }
}

extension AppRoute {
    var id: String { String(describing: self) }
}

// MARK: - Support -

private extension UIApplication {
    var topPresentedViewController: UIViewController? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first?
            .keyWindow?
            .rootViewController?
            .topPresentedViewController
    }
}

private extension UIViewController {
    /// Returns topmost presented view controller on `self`.
    var topPresentedViewController: UIViewController {
        var topController: UIViewController = self
        while let presenter = topController.presentedViewController {
            topController = presenter
        }
        return topController
    }
}
