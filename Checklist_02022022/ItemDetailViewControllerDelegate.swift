//
//  AddItemViewController.swift
//  Checklist_02022022
//
//  Created by David Thompson on 3.02.2022.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func ItemDetailViewControllerDidCancel(_ controller: ItemDetailViewControllerDelegate)
    func ItemDetailViewController(_ controller: ItemDetailViewControllerDelegate, didFinishAdding item: ChecklistItem)
    func ItemDetailViewController(_ controller: ItemDetailViewControllerDelegate, didFinishEditing item: ChecklistItem)
}

class ItemDetailViewControllerDelegate: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    weak var delegate: AddItemViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        textField.becomeFirstResponder()
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
        }
    }
  
    @IBAction func cancel() {
     delegate?.ItemDetailViewControllerDidCancel(self)
    }
    @IBAction func done() {
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.ItemDetailViewController(self, didFinishEditing: item)
        } else {
            let item = ChecklistItem()
            item.text = textField.text!
            delegate?.ItemDetailViewController(self, didFinishAdding: item)
        }
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
