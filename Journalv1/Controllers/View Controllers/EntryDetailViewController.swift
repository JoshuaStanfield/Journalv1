//
//  EntryDetailViewController.swift
//  Journalv1
//
//  Created by Stanfield on 8/20/21.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Properties
    var entry: Entry?
    var journal: Journal?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - IBActions
    @IBAction func clearFieldsButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let timestamp = Date()
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty,
              let journal = journal else { return }
        if let entry = entry {
            EntryController.update(entry: entry, title: title, body: body, timestamp: timestamp)
        } else {
            EntryController.createEntryWith(title: title, body: body, timestamp: timestamp, journal: journal)
        }
        //return to rootVC.
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Functions
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
