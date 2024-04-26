//
//  ContentView.swift
//  happily
//
//  Created by Ethan Netz on 3/29/24.
//

import MapKit
import RealmSwift
import SwiftUI

enum MapDefaults {
    static let latitude: CLLocationDegrees = 40.731089943226536
    static let longitude: CLLocationDegrees = -74.00424135952183
}

struct LocationOfIntrest: Identifiable {
    var coordinate: CLLocationCoordinate2D
    var color: Color?
    var tint: Color { color ?? .red }
    let id = UUID()
}

struct ContentView: View {
    @Environment(\.isPreview) var isPreview

    let configuration: Realm.Configuration?
    @ObservedResults(Spot.self, configuration: nil) private var observedSpots

    init(configuration: Realm.Configuration?) {
        self.configuration = configuration
        _observedSpots = ObservedResults(Spot.self, configuration: configuration)
    }

    var spots: [Spot] {
        isPreview ? Spot.spotArray : Array(observedSpots)
    }

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.748817, longitude: -73.985428),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)

    let home = CLLocationCoordinate2D(
        latitude: 40.731089943226536,
        longitude: -74.00424135952183
    )

    let locations = [
        LocationOfIntrest(
            coordinate: CLLocationCoordinate2D(
                latitude: MapDefaults.latitude,
                longitude: MapDefaults.longitude
            )
        ),
    ]

    var body: some View {
        Text("My spots:")
        List {
            ForEach(spots) { spot in
                Text(spot.name ?? "My placeholder")
            }
        }
//        Map(
//            position: $position,
//            bounds: MapCameraBounds(minimumDistance: 100, maximumDistance: 4000000)
//        ) {
//            ForEach(locations) { item in
//                Marker(
//                    "Hey",
//                    coordinate: item.coordinate
//                ).tint(item.tint)
//            }
//        }.onAppear {
//            CLLocationManager().requestWhenInUseAuthorization()
//        }
    }
}

#Preview {
    ContentView(configuration: nil)
}
