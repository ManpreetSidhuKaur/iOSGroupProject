//
//  ParkingSpaceViewModel.swift
//  iOSGroupProject
//
//  Created by Sasidurka on 2024-12-12.
//

import Foundation
import CoreData
import CoreLocation

class ParkingSpaceViewModel: ObservableObject {
    @Published var parkingSpaces: [ParkingSpace] = []

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchParkingSpaces()
    }

    func fetchParkingSpaces() {
        let request: NSFetchRequest<ParkingSpace> = ParkingSpace.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        do {
            parkingSpaces = try context.fetch(request)
        } catch {
            print("Failed to fetch parking spaces: \(error.localizedDescription)")
        }
    }

    func addParkingSpace(title: String, location: String, latitude: Double, longitude: Double, price: Double) {
        let parkingSpace = ParkingSpace(context: context)
        parkingSpace.id = UUID()
        parkingSpace.title = title
        parkingSpace.location = location
        parkingSpace.latitude = latitude
        parkingSpace.longitude = longitude
        parkingSpace.price = price
        parkingSpace.availability = true
        
        fetchParkingSpaces()

        saveContext()
        
    }
    
    func deleteParkingSpace(parkingSpace: ParkingSpace) {
            context.delete(parkingSpace)
            saveContext()
            fetchParkingSpaces()
        }

     func saveContext() {
        do {
            try context.save()
            fetchParkingSpaces()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
    
    
}
