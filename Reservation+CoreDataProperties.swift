//
//  Reservation+CoreDataProperties.swift
//  iOSGroupProject
//
//  Created by Sasidurka on 2024-12-12.
//
//

import Foundation
import CoreData


extension Reservation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reservation> {
        return NSFetchRequest<Reservation>(entityName: "Reservation")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var parkingSpaceID: UUID?
    @NSManaged public var renterName: String?
    @NSManaged public var date: Date?
    @NSManaged public var time: Date?

}

extension Reservation : Identifiable {

}
