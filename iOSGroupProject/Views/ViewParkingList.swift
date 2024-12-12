//
//  ViewParkingList.swift
//  iOSGroupProject
//
//  Created by Sasidurka on 2024-12-12.
//


import SwiftUI
import CoreData
struct ViewParkingList: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel: ParkingSpaceViewModel

    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: ParkingSpaceViewModel(context: context))
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.parkingSpaces, id: \.id) { space in
                    NavigationLink(destination: EditParkingView(parkingSpace: space, context: context)) {
                        ParkingRowView(space: space)
                    }
                }
                .onDelete(perform: deleteParkingSpaces)
            }
            .navigationTitle("My Listings")
            .toolbar {
                EditButton()
            }
        }
    }

    /// Deletes parking spaces from the list and Core Data
    private func deleteParkingSpaces(at offsets: IndexSet) {
        offsets.map { viewModel.parkingSpaces[$0] }.forEach { space in
            viewModel.deleteParkingSpace(parkingSpace: space)
        }
    }
}

struct ParkingRowView: View {
    var space: ParkingSpace

    var body: some View {
        VStack(alignment: .leading) {
            Text(space.title)
                .font(.headline)
            Text(space.location)
                .font(.subheadline)
            Text("Price: $\(space.price, specifier: "%.2f")")
                .font(.caption)
        }
    }
}
