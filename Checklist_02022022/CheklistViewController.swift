//
//  ViewController.swift
//  Checklist_02022022
//
//  Created by David Thompson on 2.02.2022.
//

import UIKit

class CheklistViewController: UITableViewController,AddItemViewControllerDelegate {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem) {
        let newRowİndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowİndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    // tanımlamalar
    //var itemToEdit = ChecklistItem?
    var items = [ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item1 = ChecklistItem()
        item1.text = "ChecklistItem"
        items.append(item1)
        let item2 = ChecklistItem()
        item2.text = "Brush my teeth"
        items.append(item2)
        let item3 = ChecklistItem()
        item3.text = "Learn iOS development"
        items.append(item3)
        let item4 = ChecklistItem()
        item4.text = "Soccer practice"
        items.append(item4)
        let item5 = ChecklistItem()
        item5.text = "Eat ice cream"
        items.append(item5)
        navigationController?.navigationBar.prefersLargeTitles = true
        /*
         if let itemToEdit {
            title = "Edit Item"
            textField.text = item.text
        }
    */
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
        configureCheckmark(for: cell, with: item)
        configureText(for: cell, with: item)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.checked.toggle()
            configureCheckmark(for: cell, with: item)
    }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func configureCheckmark( for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
    func configureText( for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
  
    // MARK: - actions
    @IBAction func addItem() {
        let newRowİndex = items.count
        let item = ChecklistItem()
        item.text = "I am a new row"
        items.append(item)
        let indexPath = IndexPath(row: newRowİndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    override func prepare(
     for segue: UIStoryboardSegue,
     sender: Any?
    ) {
     // 1
     if segue.identifier == "AddItem" {
     // 2
     let controller = segue.destination as! AddItemViewController
     // 3
     controller.delegate = self
     }
    }

    
}


