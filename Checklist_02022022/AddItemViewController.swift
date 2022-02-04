//
//  AddItemViewController.swift
//  Checklist_02022022
//
//  Created by David Thompson on 3.02.2022.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    weak var delegate: AddItemViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        textField.becomeFirstResponder()
    }
    // MARK: - protocol
    @IBAction func cancel() {
     delegate?.addItemViewControllerDidCancel(self)
    }
    @IBAction func done() {
     let item = ChecklistItem()
     item.text = textField.text!
     delegate?.addItemViewController(self, didFinishAdding: item)
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) ->IndexPath? {
        return nil
    }
    func textField(_ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String) -> Bool {
        let oldText = textField.text!
         let stringRange = Range(range, in: oldText)!
         let newText = oldText.replacingCharacters(
         in: stringRange,
         with: string)
         if newText.isEmpty {
         doneBarButton.isEnabled = false
         } else {
         doneBarButton.isEnabled = true
         }
         return true
}
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
   
}
