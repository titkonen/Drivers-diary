import CoreData

struct CoreDataManager {
    
    // MARK: PROPERTIES
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Simple-cms")
        container.loadPersistentStores(completionHandler: { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of stores failed \(err)")
            }
            
        })
        return container
    }()
    
    // MARK: Create Note folder
    func createNoteFolder(title: String) -> ClientsCategory { ///ClientsCategory is a Core Data entity name
        let context = persistentContainer.viewContext
        let newNoteFolder = NSEntityDescription.insertNewObject(forEntityName: "ClientsCategory", into: context)
        newNoteFolder.setValue(title, forKey: "title")
        
        do {
            try context.save()
            return newNoteFolder as! ClientsCategory
        } catch let err {
            print("Failed to save new note folder", err)
          return newNoteFolder as! ClientsCategory
        }
    }
    
    // MARK: Fetch noteFolders
    func fetchNoteFolders() -> [ClientsCategory] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ClientsCategory>(entityName: "ClientsCategory")
        
        do {
            let noteFolders = try context.fetch(fetchRequest)
            return noteFolders
        } catch let err {
            print("Failed to fetch note folders",err)
            return []
        }
    }
    
    // MARK:  Delete note folders
    func deleteNoteFolder(noteFolder: ClientsCategory) -> Bool {
        let context = persistentContainer.viewContext
        context.delete(noteFolder)
        
        do {
            try context.save()
            return true
        } catch let err {
            print("Error deleting note folders entity instance", err)
            return false
        }
    }
    
    // MARK: SINGLE NOTE FUNCTIONS
    // MARK: Create New Note
    func createNewNote(
        title: String,
        date: Date,
        text: String,
        jobtitle: String,
        email: String,
        phoneNumber: String,
        status: String) -> Note {
        //noteFolder: ClientsCategory) -> Note {
        let context = persistentContainer.viewContext
        let newNote = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        
        //newNote.setValue(title, forKey: "title")
        newNote.title = title
        newNote.text = text
        newNote.date = date
        //newNote.clientsCategory = noteFolder
        newNote.jobtitle = jobtitle
        newNote.email = email
        newNote.phoneNumber = phoneNumber
        newNote.status = status
        
        do {
            try context.save()
            return newNote
        } catch let err {
            print("Failed to save new note", err)
          return newNote
        }
    }
    
    // MARK: Fetch Notes
    func fetchNotes(from noteFolder: ClientsCategory) -> [Note] {
        guard let folderNotes = noteFolder.notes?.allObjects as? [Note] else {
            return []
        }
        return folderNotes
    }
    
    // MARK:  Delete notes
    func deleteNote(note: Note) -> Bool {
        let context = persistentContainer.viewContext
        context.delete(note)
        
        do {
            try context.save()
            return true
        } catch let err {
            print("Error deleting note entity instance", err)
            return false
        }
    }
    
    // MARK:  Update notes
    func saveUpdatedNote(
        note: Note,
        newText: String,
        newPreview: String,
        newJobtitle: String,
        newEmail: String,
        newPhoneNumber: String,
        newStatus: String
    ) {
        let context = persistentContainer.viewContext
        
        note.title = newText
        note.text = newPreview
        note.date = Date()
        note.jobtitle = newJobtitle
        note.email = newEmail
        note.phoneNumber = newPhoneNumber
        note.status = newStatus
        
        do {
            try context.save()
        } catch let err {
            print("Failed to update note", err)
        }
        
    }
    
    
    
}
