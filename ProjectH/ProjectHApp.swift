//
//  ProjectHApp.swift
//  ProjectH
//
//  Created by 송지혁 on 5/11/24.
//

import FirebaseCore
import SwiftUI
import SwiftData

@main
struct ProjectHApp: App {
//    @Environment(\.scenePhase) var scenePhase
    var modelContainer: ModelContainer = {
        let schema = Schema([Hackathon.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
           return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
                .environmentObject(UserModel(modelContext: modelContainer.mainContext))
                
        }
//        .onChange(of: scenePhase) { newScenePhase in
//            switch newScenePhase {
//            case .active:
//            case .inactive:
//            case .background:
//            default:
//                
//            }
//        }
    }
}
