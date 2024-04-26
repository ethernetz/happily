import RealmSwift
import SwiftUI

@main
struct happilyApp: SwiftUI.App {
    let realmAppConfig: AppConfig
    let app: RealmSwift.App
    let errorHandler: ErrorHandler
    init() {
        realmAppConfig = loadRealmAppConfig()
        app = App(id: realmAppConfig.appId, configuration: AppConfiguration(baseURL: realmAppConfig.baseUrl, transport: nil))
        errorHandler = ErrorHandler(app: app)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(errorHandler)
                .task {
                    if let user = try? await getUser(app: app) {
                        print("Signed in as \(user)")
                        do {
                            let data = try await RealmManager.shared.fetchSpots(user: user)
                            print("Got data \(data.count)")

//                            try await RealmManager.shared.addDog(user: user)
//
//                            let afterData = try await RealmManager.shared.fetchSpots(user: user)
//                            print("Got afterData \(afterData.count)")
                        } catch {
                            // Log the error details here
                            print("Error getting data: \(error.localizedDescription)")
                            // You can also implement more sophisticated logging mechanisms like os_log
                        }
                    } else {
                        print("Failed to sign in.")
                    }
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

func getUser(app: RealmSwift.App) async throws -> User {
    if let user = app.currentUser {
        return user
    } else {
        return try await app.login(credentials: Credentials.anonymous)
    }
}
