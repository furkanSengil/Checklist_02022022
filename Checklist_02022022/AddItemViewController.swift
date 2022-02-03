//
//  AddItemViewController.swift
//  Checklist_02022022
//
//  Created by David Thompson on 3.02.2022.
//

import UIKit

class AddItemViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    @IBAction func cancel() {
   navigationController?.popViewController(animated: true)
}
    @IBAction func done() {
   navigationController?.popViewController(animated: true)
}
}

