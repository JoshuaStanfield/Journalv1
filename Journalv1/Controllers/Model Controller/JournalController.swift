//
//  JournalController.swift
//  Journalv1
//
//  Created by Stanfield on 8/21/21.
//

import Foundation

class JournalCountroller {
    
    // MARK: - Shared Instance
    static let shared = JournalCountroller()
    
    // MARK: - SOT
    var journals: [Journal] = []
    
    // MARK: - CRUD Functions
    
    //create journals
    func createJournalWith(title: String) {
        let newJournal = Journal(title: title)
        self.journals.append(newJournal)
        saveToPersistenceStore()
    }
    
    //delete journals
    func delete(journal: Journal) {
        guard let index = journals.firstIndex(of: journal) else { return }
        journals.remove(at: index)
        saveToPersistenceStore()
    }
    
    ///add an entry to an existing journal.
    func addEntryTo(journal: Journal, entry: Entry) {
        journal.entries.append(entry)
        saveToPersistenceStore()
    }
    
    ///remove an entry from a journal.
    func removeEntryFrom(journal: Journal, entry: Entry) {
        guard let index = journal.entries.firstIndex(of: entry) else { return }
        journal.entries.remove(at: index)
        saveToPersistenceStore()
    }
    
    // MARK: - Persistence
    
    //fileURL
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Journalv1.json")
        return fileURL
    }
    
    // Save
    func saveToPersistenceStore() {
        
        do {
            let data = try JSONEncoder().encode(journals)
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    // Load
    func loadFromPersistanceStore() {
        do{
            let data = try Data(contentsOf: fileURL())
            journals = try JSONDecoder().decode([Journal].self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
