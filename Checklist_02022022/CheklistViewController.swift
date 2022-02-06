//
//  ViewController.swift
//  Checklist_02022022
//
//  Created by David Thompson on 2.02.2022.
//

import UIKit

class CheklistViewController: UITableViewController,AddItemViewControllerDelegate {
    func ItemDetailViewControllerDidCancel(_ controller: ItemDetailViewControllerDelegate) {
        navigationController?.popViewController(animated: true)
    }
    
    func ItemDetailViewController(_ controller: ItemDetailViewControllerDelegate, didFinishAdding item: ChecklistItem) {
        let newRowİndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowİndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        saveChecklistItems()
        navigationController?.popViewController(animated: true)
        
    }
    func ItemDetailViewController(_ controller: ItemDetailViewControllerDelegate,didFinishEditing item: ChecklistItem) {
        if let index = items.firstIndex(of: item) {
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) {
            configureText(for: cell, with: item)
        }
    }
        saveChecklistItems()
        navigationController?.popViewController(animated: true)
    }
    func saveChecklistItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(items)
            try data.write(
                to: dataFilePath() ,
                options: Data.WritingOptions.atomic
            )
        } catch {
            print("Error encoding item arrays = \(error.localizedDescription)")
        }
    }
    func loadChecklistItem() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                items = try decoder.decode([ChecklistItem].self, from: data)
            } catch {
                print("error decoding ietm arrays: \(error.localizedDescription)")
            }
        }
    }
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    // tanımlamalar
    //var itemToEdit = ChecklistItem?
    var items = [ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationController?.navigationBar.prefersLargeTitles = true
        loadChecklistItem()
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
            saveChecklistItems()
    }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func configureCheckmark( for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "👍"
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
        saveChecklistItems()
    }
    override func prepare(
     for segue: UIStoryboardSegue,
     sender: Any?
    ) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDetailViewControllerDelegate
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
        let controller = segue.destination as! ItemDetailViewControllerDelegate
        controller.delegate = self
        if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
            controller.itemToEdit = items[indexPath.row]
        }
     }
    }
}
