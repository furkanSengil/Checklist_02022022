//
//  ViewController.swift
//  Checklist_02022022
//
//  Created by David Thompson on 2.02.2022.
//

import UIKit

class CheklistViewController: UITableViewController {
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
    }
    func configureCheckmark( for cell: UITableViewCell, at indexPath: IndexPath) {
        let item = items[indexPath.row]
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
        configureCheckmark(for: cell, at: indexPath)
        return cell
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.checked.toggle()
        configureCheckmark(for: cell, at: indexPath)
    }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

