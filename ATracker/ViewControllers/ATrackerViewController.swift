//
//  ViewController.swift
//  ATracker
//
//  Created by Hector on 10/16/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Cocoa

class ATrackerViewController: NSViewController {
    
    let list = ["list one", "list two", "list 100"]
    
    @IBOutlet var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override var representedObject: Any? {
        didSet {
        }
    }
}

extension ATrackerViewController: NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return list.count
    }
}

extension ATrackerViewController: NSTableViewDelegate {
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView
        
        cell.textField?.stringValue = "\(list[row])"
        
        return cell
    }

}