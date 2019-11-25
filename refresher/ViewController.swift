//
//  ViewController.swift
//  refresher
//
//  Created by Lorin on 25/11/19.
//  Copyright © 2019 Lorin. All rights reserved.
//

import SnapKit
import UIKit

class ViewController: UITableViewController {

    let cellId = "simpleCell"
    let rowCount = 15
    let tableData: [Int] = Array(1...15)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "\(tableData[indexPath.row])"
        return cell
    }
}

