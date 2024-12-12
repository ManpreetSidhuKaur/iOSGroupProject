//
//  ParkingSpaceListView.swift
//  iOSGroupProject
//
//  Created by Sasidurka on 2024-12-12.
//

import SwiftUI

struct ParkingSpaceListView: View {
    @StateObject var viewModel: ParkingSpaceViewModel
    @Environment(\.managedObjectContext) private var viewContext

    

    var body: some View {
        NavigationView {
            List(viewModel.parkingSpaces, id: \.id) { space in
                VStack(alignment: .leading) {
                    Text(space.title)
                        .font(.headline)
                    Text(space.location)
                        .font(.subheadline)
                    Text("$\(space.price, specifier: "%.2f")")
                        .font(.caption)
                }
            }
            .navigationTitle("Parking Spaces")
            .toolbar {
                Button("Add") {
                    viewModel.addParkingSpace(
                        title: "New Space",
                        location: "123 Street",
                        latitude: 37.7749,
                        longitude: -122.4194,
                        price: 10.0
                    )
                }
            }
            
            
        }
    }
}

