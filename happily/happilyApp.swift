import RealmSwift
import SwiftUI

@main
struct HappilyApp: SwiftUI.App {
    let realmAppConfig: AppConfig
    let app: RealmSwift.App
    let errorHandler: ErrorHandler

    @State private var configuration: Realm.Configuration?

    init() {
        realmAppConfig = loadRealmAppConfig()
        app = App(id: realmAppConfig.appId, configuration: AppConfiguration(baseURL: realmAppConfig.baseUrl))
        errorHandler = ErrorHandler(app: app)
    }

    var body: some Scene {
        WindowGroup {
            if let configuration = configuration {
                ContentView(configuration: configuration)
                    .environmentObject(errorHandler)
            } else {
                Text("Signing in...")
                    .onAppear {
                        signInUser()
                    }
            }
        }
    }

    private func signInUser() {
        Task {
            if let user = try? await RealmManager.shared.getUser(app: app) {
                print("Signed in as \(user)")
                configuration = user.flexibleSyncConfiguration()
                do {
                    let data = try await RealmManager.shared.fetchSpots(user: user)
                    print("Got data \(data.count)")
                } catch {
                    print("Error getting data: \(error.localizedDescription)")
                }
            } else {
                print("Failed to sign in.")
            }
        }
    }
}

final class ErrorHandler: ObservableObject {
    @Published var error: Swift.Error?

    init(app: RealmSwift.App) {
        // Sync Manager listens for sync errors.
        app.syncManager.errorHandler = { [weak self] syncError, _ in
            DispatchQueue.main.async {
                self?.error = syncError
            }
        }
    }
}
