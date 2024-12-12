//
//  BookParkingView.swift
//  iOSGroupProject
//
//  Created by Sasidurka on 2024-12-12.
//

import SwiftUI
import CoreData

struct BookParkingView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel: ParkingSpaceViewModel

    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: ParkingSpaceViewModel(context: context))
    }

    var body: some View {
        NavigationView {
            List(viewModel.parkingSpaces.filter { $0.availability }) { space in
                VStack(alignment: .leading) {
                    Text(space.title)
                        .font(.headline)
                    Text(space.location)
                        .font(.subheadline)
                    Text("Price: $\(space.price, specifier: "%.2f")")
                        .font(.caption)
                }
                .onTapGesture {
                    // Add booking logic here
                }
            }
            .navigationTitle("Available Spaces")
        }
    }
}

