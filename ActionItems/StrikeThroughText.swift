//
//  StrikeThroughText.swift
//  ActionItems
//
//  Created by Benjamin Shyong on 1/24/15.
//  Copyright (c) 2015 Common Sense Labs. All rights reserved.
//

import UIKit
import QuartzCore

class StrikeThroughText: UITextField {
  let strikeThroughLayer: CALayer
  var strikeThrough : Bool {
    didSet {
      strikeThroughLayer.hidden = !strikeThrough
      if strikeThrough {
        resizeStrikeThrough()
      }
    }
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("NSCoder not supported")
  }

  override init(frame: CGRect) {
    strikeThroughLayer = CALayer()
    strikeThroughLayer.backgroundColor = UIColor.whiteColor().CGColor
    strikeThroughLayer.hidden = true
    strikeThrough = false
    
    super.init(frame: frame)
    layer.addSublayer(strikeThroughLayer)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    resizeStrikeThrough()
  }
  
  let kStrikeOutThickness: CGFloat = 2.0
  func resizeStrikeThrough() {
    let textSize = text!.sizeWithAttributes([NSFontAttributeName:font])
    strikeThroughLayer.frame = CGRect(x: 0, y: bounds.size.height/2, width: textSize.width, height: kStrikeOutThickness)
  }
  
  
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
