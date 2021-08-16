//
//  PlantTrackerApp.swift
//  PlantTracker
//
//  Created by Jackson Dowden on 8/10/21.
//

import SwiftUI


@main
struct PlantTrackerApp: App {
    
    @StateObject var contentViewModel: ContentViewModel = ContentViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(contentViewModel)
        }
    }
}
