//
//  ParkingSpace+CoreDataProperties.swift
//  iOSGroupProject
//
//  Created by Sasidurka on 2024-12-12.
//
//

import Foundation
import CoreData


extension ParkingSpace {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ParkingSpace> {
        return NSFetchRequest<ParkingSpace>(entityName: "ParkingSpace")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var location: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var availability: Bool
    @NSManaged public var price: Double

}

extension ParkingSpace : Identifiable {

}
