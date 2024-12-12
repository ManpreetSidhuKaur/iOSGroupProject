//
//  Persistence.swift
//  iOSGroupProject
//
//
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // The Core Data container
    let container: NSPersistentContainer
    
    static var preview: PersistenceController = {
            let result = PersistenceController(inMemory: true)
            let viewContext = result.container.viewContext

            // Add mock data here if needed
            let mockParkingSpace = ParkingSpace(context: viewContext)
            mockParkingSpace.id = UUID()
            mockParkingSpace.title = "Downtown Parking Spot"
            mockParkingSpace.location = "123 Main Street"
            mockParkingSpace.latitude = 37.7749
            mockParkingSpace.longitude = -122.4194
            mockParkingSpace.price = 10.0
            mockParkingSpace.availability = true

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }

            return result
        }()

    // MARK: - Initialization
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "iOSGroupProject")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    // MARK: - Save Context
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
