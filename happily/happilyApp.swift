//
//  happilyApp.swift
//  happily
//
//  Created by Ethan Netz on 3/29/24.
//

import SwiftUI
import RealmSwift
let app = RealmSwift.App(id: "application-0-fvtyw") // TODO: Set the Realm application ID
@main
struct happilyApp: SwiftUI.App {
   @StateObject var state = AppState()

   var body: some Scene {
      WindowGroup {
            ContentView()
               .environmentObject(state)
      }
   }
}
