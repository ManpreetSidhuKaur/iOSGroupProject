//
//  EditParkingViewModel.swift
//  iOSGroupProject
//
//  Created by Sasidurka on 2024-12-12.
//

import Foundation
import CoreLocation
import CoreData

class EditParkingViewModel: ObservableObject {
    private let context: NSManagedObjectContext
    @Published var title: String
    @Published var address: String
    @Published var price: Double
    @Published var latitude: Double
    @Published var longitude: Double
    @Published var errorMessage: String? = nil

    private var parkingSpace: ParkingSpace

    init(parkingSpace: ParkingSpace, context: NSManagedObjectContext) {
        self.context = context
        self.parkingSpace = parkingSpace
        self.title = parkingSpace.title
        self.address = parkingSpace.location
        self.price = parkingSpace.price
        self.latitude = parkingSpace.latitude
        self.longitude = parkingSpace.longitude
    }

    /// Saves the updated parking space details to Core Data
    func saveChanges(completion: @escaping (Bool) -> Void) {
        geocodeAddress { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let coordinates):
                    self.parkingSpace.title = self.title
                    self.parkingSpace.location = self.address
                    self.parkingSpace.price = self.price
                    self.parkingSpace.latitude = coordinates.latitude
                    self.parkingSpace.longitude = coordinates.longitude
                    do {
                        try self.context.save()
                        completion(true)
                    } catch {
                        self.errorMessage = "Failed to save changes."
                        completion(false)
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }

    /// Deletes the parking space from Core Data
    func deleteParkingSpace(completion: @escaping (Bool) -> Void) {
        context.delete(parkingSpace)
        do {
            try context.save()
            completion(true)
        } catch {
            errorMessage = "Failed to delete parking space."
            completion(false)
        }
    }

    /// Geocodes the updated address
    private func geocodeAddress(completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                completion(.failure(error))
            } else if let location = placemarks?.first?.location {
                completion(.success(location.coordinate))
            } else {
                completion(.failure(NSError(domain: "GeocodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch coordinates."])))
            }
        }
    }
}
