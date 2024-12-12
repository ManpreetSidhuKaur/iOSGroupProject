//
//  ParkingWidget.swift
//  iOSGroupProject
//
//  Created by Sasidurka on 2024-12-12.
//

import WidgetKit
import SwiftUI

struct ParkingWidgetEntry: TimelineEntry {
    let date: Date
    let parkingSpaces: [ParkingSpace]
}

struct ParkingWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> ParkingWidgetEntry {
        ParkingWidgetEntry(date: Date(), parkingSpaces: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (ParkingWidgetEntry) -> ()) {
        completion(ParkingWidgetEntry(date: Date(), parkingSpaces: []))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ParkingWidgetEntry>) -> ()) {
        let entry = ParkingWidgetEntry(date: Date(), parkingSpaces: [])
        completion(Timeline(entries: [entry], policy: .atEnd))
    }
}

struct ParkingWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "ParkingWidget", provider: ParkingWidgetProvider()) { entry in
            Text("Nearest Parking Space")
        }
        .configurationDisplayName("Parking Finder")
        .description("Shows the nearest available parking space.")
    }
}
