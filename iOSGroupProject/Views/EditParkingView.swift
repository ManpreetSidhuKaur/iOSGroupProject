//
//  EditParkingView.swift
//  iOSGroupProject
//
//  Created by Sasidurka on 2024-12-12.
//

import SwiftUI
import CoreData

struct EditParkingView: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var viewModel: EditParkingViewModel

    init(parkingSpace: ParkingSpace, context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: EditParkingViewModel(parkingSpace: parkingSpace, context: context))
    }

    var body: some View {
        Form {
            Section(header: Text("Edit Parking Details")) {
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Address", text: $viewModel.address)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                HStack {
                    Text("Price (per hour):")
                    Spacer()
                    TextField("Enter price", value: $viewModel.price, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 100)
                }

//                HStack {
//                    Text("Latitude:")
//                    Spacer()
//                    Text("\(viewModel.latitude, specifier: "%.4f")")
//                        .foregroundColor(.gray)
//                }
//
//                HStack {
//                    Text("Longitude:")
//                    Spacer()
//                    Text("\(viewModel.longitude, specifier: "%.4f")")
//                        .foregroundColor(.gray)
//                }

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }

            Section {
                Button(action: saveChanges) {
                    Text("Save Changes")
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(role: .destructive, action: deleteParkingSpace) {
                    Text("Delete Parking Space")
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .navigationTitle("Edit Parking Space")
    }

    private func saveChanges() {
        viewModel.saveChanges { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }

    private func deleteParkingSpace() {
        viewModel.deleteParkingSpace { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

