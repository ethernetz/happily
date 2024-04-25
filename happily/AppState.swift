//
//  AppState.swift
//  happily
//
//  Created by Ethan Netz on 3/31/24.
//

import RealmSwift
import SwiftUI
import Combine

class AppState: ObservableObject {
//    private var token: NotificationToken?
    @Published var locations: [Spot] = []
    // Placeholder for future user authentication implementation.
    // var user: User?

    init() {
        // Assuming `Location` objects are already being observed and managed within the specific view's Realm instance,
        // here you could initialize anything not directly related to the Realm instance, e.g., user state.
        
        // If you're planning to introduce user authentication later, initialization related to checking the user's logged-in state could go here.
        
        // For directly working with `Location` objects in a view, consider fetching and observing them within the view or a view model dedicated to that view.
    }
    
    // Consider adding methods here to manage the user state, such as logging in, logging out, and handling user session.
    
    // If you find the need to globally observe `Location` objects across multiple views, you can implement fetching and observing logic here, similar to the earlier example. However, with the SDK update, it might be more efficient to handle this within each view or a dedicated view model.
}
