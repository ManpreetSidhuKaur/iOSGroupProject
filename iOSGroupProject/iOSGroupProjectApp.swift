//
//  iOSGroupProjectApp.swift
//  iOSGroupProject
//

import SwiftUI

@main
struct iOSGroupProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct MainTabView: View {
    @Environment(\.managedObjectContext) private var context

    var body: some View {
        TabView {
            PostParkingView(context: context)
                .tabItem {
                    Label("Post Space", systemImage: "plus.square.fill")
                }

            ViewParkingList(context: context)
                .tabItem {
                    Label("My Listings", systemImage: "list.bullet")
                }

            BookParkingView(context: context)
                .tabItem {
                    Label("Reservations", systemImage: "calendar")
                }
        }
    }
}

// Placeholder Views

struct PostParkingSpaceView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            Text("Post Parking Space")
                .navigationTitle("Post Parking Space")
        }
    }
}

struct MyListingsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            Text("My Listings")
                .navigationTitle("My Listings")
        }
    }
}

struct RentersReservationsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            Text("Renter's Reservations")
                .navigationTitle("Reservations")
        }
    }
}
