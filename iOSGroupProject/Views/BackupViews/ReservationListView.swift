//
//  ReservationListView.swift
//  iOSGroupProject
//
//  Created by Sasidurka on 2024-12-12.
//

import SwiftUI


struct ReservationListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @StateObject var viewModel: ReservationViewModel
    
    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \ParkingSpace.title, ascending: true)],
            animation: .default
        ) private var parkingSpaces: FetchedResults<ParkingSpace>

    var body: some View {
        NavigationView {
            List(viewModel.reservations, id: \.id) { reservation in
                VStack(alignment: .leading) {
                    Text("Renter: \(reservation.renterName)")
                    Text("Date: \(reservation.date, formatter: dateFormatter)")
                    Text("Time: \(reservation.time, formatter: timeFormatter)")
                }
            }
            .navigationTitle("Reservations")
        }
    }
}

let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter
}()

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

