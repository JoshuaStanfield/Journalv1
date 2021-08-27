//
//  JournalListViewController.swift
//  Journalv1
//
//  Created by Stanfield on 8/22/21.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalListTableView: UITableView!
    
    // MARK: - Properties & Identifiers
    let journalCell = "journalCell"
    let toEntryList = "toEntryList"
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        JournalCountroller.shared.loadFromPersistanceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        journalListTableView.reloadData()
    }
    
    // MARK: - IBActions
    @IBAction func createNewJournalButtonTapped(_ sender: Any) {
        guard let title = journalTitleTextField.text, !title.isEmpty else { return }
        JournalCountroller.shared.createJournalWith(title: title)
        journalListTableView.reloadData()
        journalTitleTextField.text = ""
    }
    
    // MARK: - Data Source Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalCountroller.shared.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: journalCell, for: indexPath)
        
        let journal = JournalCountroller.shared.journals[indexPath.row]
        
        cell.textLabel?.text = journal.title
        cell.detailTextLabel?.text = "\(journal.entries.count)"
        
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO: Identifier, index, destination, object to send, object to receive.
        if segue.identifier == toEntryList {
            if let index = journalListTableView.indexPathForSelectedRow {
                if let destinationVC = segue.destination as? EntryListTableViewController {
                    let journalToSend = JournalCountroller.shared.journals[index.row]
                    destinationVC.journal = journalToSend
                    
                }
            }
        }
    }
}
