//
//  ReservationFormView.swift
//  iOSGroupProject
//
//  Created by Sasidurka on 2024-12-12.
//

import SwiftUI

struct ReservationFormView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @StateObject var viewModel: ReservationViewModel
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var renterName = ""
    @State private var parkingSpaceID: UUID

    var body: some View {
        Form {
            TextField("Renter Name", text: $renterName)

            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)

            DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)

            Button("Book Reservation") {
                viewModel.bookParkingSpace(
                    parkingSpaceID: parkingSpaceID,
                    renterName: renterName,
                    date: selectedDate,
                    time: selectedTime
                )
            }
        }
        .navigationTitle("Book Reservation")
    }
}
