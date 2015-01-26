//
//  ViewController.swift
//  ActionItems
//
//  Created by Ben on 1/20/15.
//  Copyright (c) 2015 Common Sense Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate {

  @IBOutlet weak var tableView: UITableView!
  var actionItems = [ActionItem]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    // use custom subclassed TableViewCell in tableView
    tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.rowHeight = 50.0
    tableView.separatorStyle = .None
    tableView.backgroundColor = UIColor.blackColor()

    if actionItems.count > 0 {
      return
    }

    actionItems.append(ActionItem(description: "just an item"))
    actionItems.append(ActionItem(description: "another item"))
    actionItems.append(ActionItem(description: "just an item"))
    actionItems.append(ActionItem(description: "another item"))
    actionItems.append(ActionItem(description: "just an item"))
    actionItems.append(ActionItem(description: "another item"))
    actionItems.append(ActionItem(description: "just an item"))
    actionItems.append(ActionItem(description: "another item"))
    actionItems.append(ActionItem(description: "just an item"))
    actionItems.append(ActionItem(description: "another item"))
    actionItems.append(ActionItem(description: "another item"))
    actionItems.append(ActionItem(description: "just an item"))
    actionItems.append(ActionItem(description: "another item"))
    actionItems.append(ActionItem(description: "another item"))
    actionItems.append(ActionItem(description: "just an item"))
    actionItems.append(ActionItem(description: "another item"))
    actionItems.append(ActionItem(description: "another item"))
    actionItems.append(ActionItem(description: "just an item"))
    actionItems.append(ActionItem(description: "another item"))
    
  }

  // MARK: - Table View Cell delegate
  func actionItemDeleted(actionItem: ActionItem) {
    
    let index = (actionItems as NSArray).indexOfObject(actionItem)
    if index == NSNotFound { return }
    actionItems.removeAtIndex(index)
    
    // animate removal of the row with UITableView
    tableView.beginUpdates()
    let indexPathForRow = NSIndexPath(forRow: index, inSection: 0)
    tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
    tableView.endUpdates()
  }
  
  // color cells with gradient by index
  func colorForIndex(index: Int) -> UIColor {
    let itemCount = actionItems.count - 1
    let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
    return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
  }
  
  // set cell background colors before they are displayed
  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    cell.backgroundColor = colorForIndex(indexPath.row)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // needed for versions older than iOS 8
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return tableView.rowHeight
  }
  
  // TableViewDataSourceDelegate
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return actionItems.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as TableViewCell
    // disable highlighting when cell is selected
    cell.selectionStyle = .None
    let actionItem = actionItems[indexPath.row]
    
    // cell text and background color are set in StrikeThroughLabel
//    cell.textLabel?.text = actionItem.text
//    cell.textLabel?.backgroundColor = UIColor.clearColor()

    // set delegate and actionItem properties
    cell.delegate = self
    cell.actionItem  = actionItem

    return cell
  }
  

}

