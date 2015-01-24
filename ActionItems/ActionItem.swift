//
//  ActionItem.swift
//  ActionItems
//
//  Created by Benjamin Shyong on 1/23/15.
//  Copyright (c) 2015 Common Sense Labs. All rights reserved.
//

import UIKit

class ActionItem: NSObject {
  var text: String
  var completed: Bool
  
  init(description: String) {
    self.text = description
    self.completed = false
  }
  
}
