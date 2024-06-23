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
    
    @Environment(\.scenePhase) var scenePhase
    var modelContainer: ModelContainer = {
        let schema = Schema([Hackathon.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
           return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    let user: UserModel
    
    init() {
        FirebaseApp.configure()
        self.user = UserModel(modelContext: modelContainer.mainContext)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
                .environmentObject(user)
                
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("앱 Active")
            case .inactive:
                print("앱 inactive")
            case .background:
                print("앱 background")
                user.uploadSwiftDataToFirebase()
            default:
                break
            }
        }
    }
}
