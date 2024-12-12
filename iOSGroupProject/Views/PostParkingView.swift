//
//  PostParkingView.swift
//  iOSGroupProject
//
//  Created by Sasidurka on 2024-12-12.
//


import CoreData
import SwiftUI
import CoreLocation

struct PostParkingView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel: ParkingSpaceViewModel

    @State private var title = ""
    @State private var location = ""
    @State private var price = 0.0
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0

    @State private var geocodingError: String? = nil

    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: ParkingSpaceViewModel(context: context))
    }

    var body: some View {
        Form {
            
            TextField("Title", text: $title)
            
            TextField("Address", text: $location)
            TextField("Price", value: $price, format: .number)

            if let error = geocodingError {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Button("Post Parking Space") {
                fetchCoordinates(for: location) { result in
                    switch result {
                    case .success(let coordinates):
                        latitude = coordinates.latitude
                        longitude = coordinates.longitude
                        viewModel.addParkingSpace(
                            title: title,
                            location: location,
                            latitude: latitude,
                            longitude: longitude,
                            price: price
                        )
                    case .failure(let error):
                        geocodingError = error.localizedDescription
                    }
                }
            }
        }
        .navigationTitle("Post Parking Space")
    }

    /// Fetch coordinates for a given address using CLGeocoder
    func fetchCoordinates(for address: String, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                completion(.failure(error))
            } else if let placemark = placemarks?.first, let location = placemark.location {
                completion(.success(location.coordinate))
            } else {
                completion(.failure(NSError(domain: "GeocodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get location for address."])))
            }
        }
    }
}

struct PostParkingView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        PostParkingView(context: context)
    }
}

