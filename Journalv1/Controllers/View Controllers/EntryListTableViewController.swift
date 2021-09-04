//
//  EntryListTableViewController.swift
//  Journalv1
//
//  Created by Stanfield on 8/20/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    // MARK: - IBOutlets
    
    // MARK: - Properties
    let toEntryDetailVCSegue = "toEntryDetailVC"
    let cellReuseIdentifier = "entryCell"
    let createNewEntrySegue = "toCreateNewEntry"
    
    //Segue Landing Pad
    var journal: Journal?
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = journal?.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - IBActions
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let journalCount = journal?.entries.count else { return 0 }
        return journalCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        guard let entry = journal?.entries[indexPath.row] else { return UITableViewCell() }
        
        let timestamp = EntryController.getFormattedDate(date: entry.timestamp, format: "MMM dd, yyyy | hh:mm a")
                
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = "\(timestamp)"

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Make sure we have a journal.
            guard let journal = journal else { return }
            // get the entry to delete
            let entryToDelete = journal.entries[indexPath.row]
            
            //delete the entry
            EntryController.delete(entry: entryToDelete, journal: journal)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO: Identifier, index, destination, object to send, object to receive.
        guard let journal = journal,
              let destinationVC = segue.destination as? EntryDetailViewController else { return }
        if segue.identifier == toEntryDetailVCSegue {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
                    let entryToSend = journal.entries[indexPath.row]
                    destinationVC.entry = entryToSend
                    destinationVC.journal = journal
        } else if segue.identifier == createNewEntrySegue {
                destinationVC.journal = journal
        }
    }
}
