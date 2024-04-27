import Foundation
import RealmSwift

class Spot: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var checkedForHappyHours: Bool
    @Persisted var address: String?
    @Persisted var name: String
    @Persisted var uniqueName: String?
    @Persisted var url: String?
    @Persisted var googlePlaceId: String?
    @Persisted var coordinates: Coordinates?
//    @Persisted var happyHours: List<HappyHour>

    convenience init(name: String, address: String?, url: String?, uniqueName: String?, checkedForHappyHours: Bool?, google_place_id: String?, googlePlaceId: String?, coordinates: Coordinates) {
        self.init()
        self.name = name
        self.address = address
        self.url = url
        self.uniqueName = uniqueName
        self.checkedForHappyHours = checkedForHappyHours ?? false // Handle optional Bool properly
        self.googlePlaceId = googlePlaceId
        self.coordinates = coordinates
    }
}

class Coordinates: EmbeddedObject {
    @Persisted var coordinates: List<Double> // Longitude first, then Latitude

    convenience init(longitude: Double, latitude: Double) {
        self.init()
        self.coordinates.append(objectsIn: [longitude, latitude])
    }
}

// class HappyHour: Object {
//    @Persisted var day: String
//    @Persisted var startTime: String
//    @Persisted var endTime: String
//    @Persisted var crossesMidnight: Bool
//    @Persisted var deal: String
// }

extension Spot {
    static let spot1 = Spot(
        name: "Mock Spot",
        address: "123 Mock St",
        url: "https://www.example.com",
        uniqueName: "mock_spot_123",
        checkedForHappyHours: false,
        google_place_id: "google_place_id_mock",
        googlePlaceId: "googlePlaceId_mock",
        coordinates: Coordinates(longitude: -122.009102, latitude: 37.334606)
    )
    static let spotArray = [spot1]
}
