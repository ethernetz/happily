import RealmSwift
import SwiftUI

actor RealmManager {
    static let shared = RealmManager()

    func getUser(app: RealmSwift.App) async throws -> User {
        if let user = app.currentUser {
            return user
        } else {
            return try await app.login(credentials: Credentials.anonymous)
        }
    }

    func getRealm(user: User) async throws -> Realm {
        let configuration = user.flexibleSyncConfiguration()
        _ = try Realm.deleteFiles(for: configuration)
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        return try await Realm(configuration: configuration, actor: self)
    }

    func fetchSpots(user: User) async throws -> [Spot] {
        let realm = try await getRealm(user: user)
        let results = try await realm.objects(Spot.self).where {
            $0.checkedForHappyHours
        }.subscribe(name: "sub_to_spots")
        return Array(results)
    }
}
