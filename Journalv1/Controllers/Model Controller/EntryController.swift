//
//  EntryController.swift
//  Journalv1
//
//  Created by Stanfield on 8/20/21.
//

import Foundation

class EntryController {
    
    // MARK: - CRUD Functions
    
    ///Create an Entry
    static func createEntryWith(title: String, body: String, journal: Journal) {
        let newEntry = Entry(title: title, body: body)
        JournalCountroller.shared.addEntryTo(journal: journal, entry: newEntry)
    }
    
    ///Delete an Entry
    static func delete(entry: Entry, journal: Journal) {
        JournalCountroller.shared.removeEntryFrom(journal: journal, entry: entry)
    }
    
    ///Update an Entry
    static func update(entry: Entry, title: String, body: String) {
        entry.title = title
        entry.body = body
        JournalCountroller.shared.saveToPersistenceStore()
    }
}
