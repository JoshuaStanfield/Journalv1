//
//  Journal.swift
//  Journalv1
//
//  Created by Stanfield on 8/21/21.
//

import Foundation

class Journal: Codable {
    
    let title: String
    var entries: [Entry]
    
    init(title: String, entries: [Entry] = []) {
        self.title = title
        self.entries = entries
    }
}

extension Journal: Equatable {}

func ==(lhs: Journal, rhs: Journal) -> Bool {
    if lhs.title != rhs.title { return false }
    
    return true
}
