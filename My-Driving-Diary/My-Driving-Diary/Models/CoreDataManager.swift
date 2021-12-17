import CoreData

struct CoreDataManager {
    
    // MARK: PROPERTIES
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "driving-diary-datamodel")
        container.loadPersistentStores(completionHandler: { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of stores failed \(err)")
            }
        })
        return container
    }()
    
    // MARK: CRUD FUNCTIONS
    // MARK: Create New Driving Data Entry
    func createNewDriveEntry(
        startingPlace: String,
        startingKm: Int16,
        endingPlace: String,
        timestamp: Date,
        distanceKm: Int16,
        endingKm: Int16,
        driveDescription: String) -> DrivingData {
        let context = persistentContainer.viewContext
        let newDriveEntry = NSEntityDescription.insertNewObject(forEntityName: "DrivingData", into: context) as! DrivingData

            newDriveEntry.startingPlace = startingPlace
            newDriveEntry.startingKm = startingKm
            newDriveEntry.endingPlace = endingPlace
            newDriveEntry.timestamp = timestamp
            newDriveEntry.distanceKm = distanceKm
            newDriveEntry.endingKm = endingKm
            newDriveEntry.driveDescription = driveDescription
            
        do {
            try context.save()
            print("newDriveEntry saving succeed")
            return newDriveEntry
        } catch let error {
            print("Failed to save new drive data", error)
          return newDriveEntry
        }
    }
    
    
    // MARK: Fetch Notes
//    func fetchEntries() -> [DaysEntity] {
//        guard let dayEntries = days?.allObjects as? [DaysEntity] else {
//            return []
//        }
//        return dayEntries
//    }
    
    func fetchDrivingData() -> [DrivingData] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<DrivingData>(entityName: "DrivingData")
        
        do {
            let drivingEntities = try context.fetch(fetchRequest)
            print("Fetched drivingEntities content")
            return drivingEntities
        } catch let error {
            print("Failed to fetch note folders",error)
            return []
        }
    }
    
    // MARK:  Delete Driving Data
    func deleteDrivingEntry(entry: DrivingData) -> Bool {
        let context = persistentContainer.viewContext
        context.delete(entry)
        
        do {
            try context.save()
            return true
        } catch let error {
            print("Error deleting note entity instance", error)
            return false
        }
    }
    
    // MARK:  Update Driving Data
    func saveUpdatedEntry(updatedData: DrivingData, UpdatedStartingPlace: String, UpdatedStartingKm: Int16, UpdatedEndingPlace: String, UpdatedDistanceKm: Int16, UpdatedEndingKm: Int16, UpdatedDriveDescription: String ) {
        let context = persistentContainer.viewContext
        
        updatedData.startingPlace = UpdatedStartingPlace
        updatedData.startingKm = UpdatedStartingKm
        updatedData.endingPlace = UpdatedEndingPlace
        updatedData.distanceKm = UpdatedDistanceKm
        updatedData.endingKm = UpdatedEndingKm
        updatedData.driveDescription = UpdatedDriveDescription
        updatedData.timestamp = Date()

        do {
            try context.save()
            print("Data updates succeed")
        } catch let error {
            print("Failed to update Driving Data", error)
        }
    }
    
    
    
}
