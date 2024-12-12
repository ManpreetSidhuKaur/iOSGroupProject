//
//  ReservationVM.swift
//  iOSGroupProject
//
//  Created by Sasidurka on 2024-12-12.
//

import Foundation
import CoreData

class ReservationViewModel: ObservableObject {
    private let context: NSManagedObjectContext
    @Published var reservations: [Reservation] = []

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchReservations()
    }

    func fetchReservations() {
        let request: NSFetchRequest<Reservation> = Reservation.fetchRequest()
        do {
            reservations = try context.fetch(request)
        } catch {
            print("Error fetching reservations: \(error)")
        }
    }

    func bookParkingSpace(parkingSpaceID: UUID, renterName: String, date: Date, time: Date) {
        let reservation = Reservation(context: context)
        reservation.id = UUID()
        reservation.parkingSpaceID = parkingSpaceID
        reservation.renterName = renterName
        reservation.date = date
        reservation.time = time

        saveContext()
        fetchReservations()
    }


    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}
