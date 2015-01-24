//
//  ViewController.swift
//  ActionItems
//
//  Created by Ben on 1/20/15.
//  Copyright (c) 2015 Common Sense Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  var actionItems = [ActionItem]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

    if actionItems.count > 0 {
      return
    }

    actionItems.append(ActionItem(description: "just an item"))
    actionItems.append(ActionItem(description: "another item"))
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // TableViewDataSourceDelegate
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return actionItems.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
    let item = actionItems[indexPath.row]
    
    cell.textLabel?.text = item.text

    return cell
  }
  

}

