//
//  Spot.swift
//  happily
//
//  Created by Ethan Netz on 3/31/24.
//

import Foundation
import RealmSwift

class Spot: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var checkedForHappyHours: Bool
    @Persisted var address: String?
    @Persisted var name: String?
    @Persisted var uniqueName: String?
    @Persisted var url: String?
    @Persisted var googlePlaceId: String?
    @Persisted var google_place_id: String?
//    @Persisted var coordinates: GeoPoint?

    convenience init(name: String?, address: String?, url: String?, uniqueName: String?, checkedForHappyHours: Bool?, google_place_id: String?, googlePlaceId: String?, longitude: Double, latitude: Double) {
        self.init()
        self.name = name
        self.address = address
        self.url = url
        self.uniqueName = uniqueName
        self.checkedForHappyHours = checkedForHappyHours ?? false // Handle optional Bool properly
        self.google_place_id = google_place_id
        self.googlePlaceId = googlePlaceId
//        self.coordinates = GeoPoint(longitude: longitude, latitude: latitude)
    }
}

class GeoPoint: EmbeddedObject {
    @Persisted var type: String = "Point"
    @Persisted var coordinates: List<Double> // Longitude first, then Latitude

    convenience init(longitude: Double, latitude: Double) {
        self.init()
        self.coordinates.append(objectsIn: [longitude, latitude])
    }
}

extension Spot {
    static let spot1 = Spot(
        name: "Mock Spot",
        address: "123 Mock St",
        url: "https://www.example.com",
        uniqueName: "mock_spot_123",
        checkedForHappyHours: false,
        google_place_id: "google_place_id_mock",
        googlePlaceId: "googlePlaceId_mock",
        longitude: 0.0,
        latitude: 0.0
    )
    static let spotArray = [spot1]
}
