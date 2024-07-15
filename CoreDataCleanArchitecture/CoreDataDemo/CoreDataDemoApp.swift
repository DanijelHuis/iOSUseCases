//
//  CoreDataDemoApp.swift
//  CoreDataDemo
//
//  Created by Danijel Huis on 12.07.2024..
//

import SwiftUI

@main
struct CoreDataDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var isAppReady = false
    var navigator = Navigator()
    var rootView: any View

    init() {
        rootView = NoteListView(viewModel: NoteListViewModel(manageNotesUseCase: DIContainer.noteManager,
                                                             coordinator: AppCoordinator(navigator: navigator)))
    }
    
    var body: some Scene {
        WindowGroup {
            AppNavigationStack(navigator: navigator) {
                if isAppReady {
                    AnyView(rootView)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .navigationBarTitleDisplayMode(.inline)
                } else {
                    Text("Loading...")
                }
            }
            .onFirstAppear() {
                Task {
                    do {
                        try await DIContainer.cdManager.load()
                        isAppReady = true
                        print("Successfully loaded persistent store")
                    } catch {
                        print("Error loading persistent store: \(error).")
                    }
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}

@MainActor
class TestClass {
    func doSomething() {
        Task {
            try await DIContainer.cdManager.load()
        }
    }
}
