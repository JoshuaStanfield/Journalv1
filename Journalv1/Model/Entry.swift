//
//  Entry.swift
//  Journalv1
//
//  Created by Stanfield on 8/20/21.
//

import Foundation

class Entry: Codable {
    
    var title: String
    var body: String
    let timestamp: Date
    
    init(title: String, body: String, timestamp: Date = Date()) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
    }
}

extension Entry: Equatable {}

func ==(lhs: Entry, rhs: Entry) -> Bool {
    if lhs.title != rhs.title { return false }
    if lhs.body != rhs.body { return false }
    if lhs.timestamp != rhs.timestamp { return false }
    
    return true
}
