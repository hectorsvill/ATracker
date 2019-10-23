//
//  ViewController.swift
//  ATracker
//
//  Created by Hector on 10/16/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Cocoa

class ATrackerListViewController: NSViewController {
    let aTrackerController = ATrackerController()
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    
    @IBOutlet var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStatusItem()
        tableView.delegate = self
        tableView.dataSource = self
        
        print(aTrackerController.aTrackerList.count)
        
    }
    
    private func setupStatusItem() {
        statusItem.button?.title = "𝓪Tracker"
        statusItem.button?.target = self
        statusItem.button?.action = #selector(trackIt)
    }
    
    @objc
    func trackIt() {
        let storyboad = NSStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboad.instantiateController(withIdentifier: "ATrackerItemBar") as? ATrackerTabItemViewController else {
            fatalError("Error getting status button item")
        }

        let popoverView = NSPopover()
        popoverView.contentViewController = vc
        popoverView.behavior = .transient
           
        guard let button = statusItem.button else {
            fatalError("Couldnt find status item button")
        }
           
        popoverView.show(relativeTo: button.bounds, of: button, preferredEdge: .maxX)
    }
}

 // MARK: NSTableViewDataSource

extension ATrackerListViewController: NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return aTrackerController.aTrackerList.count
    }
}

// MARK: NSTableViewDelegate
extension ATrackerListViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView
        cell.textField?.stringValue = "\(aTrackerController.aTrackerList[row].title!)"
        return cell
    }
    
    func tableView(_ tableView: NSTableView, didClick tableColumn: NSTableColumn) {
        print(tableColumn.title)
    }
}
