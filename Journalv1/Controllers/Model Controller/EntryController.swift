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
    static func createEntryWith(title: String, body: String, timestamp: Date, journal: Journal) {
        let newEntry = Entry(title: title, body: body, timestamp: timestamp)
        JournalCountroller.shared.addEntryTo(journal: journal, entry: newEntry)
    }
    
    ///Delete an Entry
    static func delete(entry: Entry, journal: Journal) {
        JournalCountroller.shared.removeEntryFrom(journal: journal, entry: entry)
    }
    
    ///Update an Entry
    static func update(entry: Entry, title: String, body: String, timestamp: Date) {
        entry.title = title
        entry.body = body
        entry.timestamp = timestamp
        JournalCountroller.shared.saveToPersistenceStore()
    }
    
    ///Format the date.
    static func getFormattedDate(date: Date, format: String) -> String {
            let dateformat = DateFormatter()
            dateformat.dateFormat = format
            return dateformat.string(from: date)
    }
}
