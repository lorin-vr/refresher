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

    private var tableData: [Int] = Array(1...15)
    
    private let cellId = "simpleCell"
    private let rowCount = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        buildView()
    }

    // MARK:- UITableViewDataSource
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
    
    // MARK:- Private helpers
    private func buildView() {
        view.backgroundColor = .white
        refreshControl = CustomSpinnerRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }
    
    @objc private func refresh(_ sender: Any) {
        refreshControl?.beginRefreshing()
        
        // Use a timer to simulate a network call that takes a while to complete
        let _ = Timer.scheduledTimer(withTimeInterval: 1.2, repeats: false, block: { timer in
            self.tableData = self.tableData.map { i in
                return i * 2
            }
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        })
    }
}

