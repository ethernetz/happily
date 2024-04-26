import RealmSwift
import SwiftUI

actor RealmManager {
    static let shared = RealmManager()

    func getRealm(user: User) async throws -> Realm {
        let configuration = user.flexibleSyncConfiguration()
        _ = try Realm.deleteFiles(for: configuration)
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        return try await Realm(configuration: configuration, actor: self)
    }

    func fetchSpots(user: User) async throws -> [Spot] {
        let realm = try await getRealm(user: user)
        let results = try await realm.objects(Spot.self).subscribe(name: "sub_to_spots")
        return Array(results)
    }
}
