//
//  TableViewCell.swift
//  ActionItems
//
//  Created by Benjamin Shyong on 1/23/15.
//  Copyright (c) 2015 Common Sense Labs. All rights reserved.
//

import UIKit
import QuartzCore

protocol TableViewCellDelegate {
  // indicates that item has been deleted
  func actionItemDeleted(actionItem: ActionItem)
}

class TableViewCell: UITableViewCell {
  
  let gradientLayer = CAGradientLayer()
  var originalCenter = CGPoint()
  var deleteOnDragRelease = false
  var completeOnDragRelease = false
  let label: StrikeThroughText
  let itemCompleteLayer = CALayer()
  
  // optional because they are set in ViewController and not in TableViewCell init method
  var delegate: TableViewCellDelegate?
  
  // add actionItem property and a didSet observer
  var actionItem: ActionItem? {
    didSet {
      label.text = actionItem!.text
      label.strikeThrough = actionItem!.completed
      itemCompleteLayer.hidden = !label.strikeThrough
    }
  }
 
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented. NSCoding not supported.")
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    // required properties need to be initialized before calling super.init
    label = StrikeThroughText(frame: CGRect.nullRect)
    label.textColor = UIColor.whiteColor()
    label.font = UIFont.boldSystemFontOfSize(16)
    label.backgroundColor = UIColor.clearColor()
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    // add StrikeThroughLabel
    addSubview(label)
    selectionStyle = .None
    
    // 4-step gradient layer for each cell
    gradientLayer.frame = bounds
    let color1 = UIColor(white: 1.0, alpha: 0.2).CGColor as CGColorRef
    let color2 = UIColor(white: 1.0, alpha: 0.1).CGColor as CGColorRef
    let color3 = UIColor.clearColor().CGColor as CGColorRef
    let color4 = UIColor(white: 0.0, alpha: 0.1).CGColor as CGColorRef
    gradientLayer.colors = [color1, color2, color3, color4]
    gradientLayer.locations = [0.0, 0.01, 0.95, 1.0]
    layer.insertSublayer(gradientLayer, atIndex: 0)
    
    // add layer to show green background when complete
    itemCompleteLayer = CALayer(layer: layer)
    itemCompleteLayer.backgroundColor = UIColor(red: 0.0, green: 0.6, blue: 0.0, alpha: 1.0).CGColor
    itemCompleteLayer.hidden = true
    layer.insertSublayer(itemCompleteLayer, atIndex: 0)
    
    // add Pan Recognizer and sets cell as delegate
    var recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
    recognizer.delegate = self
    addGestureRecognizer(recognizer)
  }

  func handlePan(recognizer: UIPanGestureRecognizer) {
    if recognizer.state == .Began {
      // record center location when gesture begins
      originalCenter = center
    }
    if recognizer.state == .Changed {
      let translation = recognizer.translationInView(self)
      center = CGPointMake(originalCenter.x + translation.x, originalCenter.y)
      // flag to delete cell if it is dragged more than half the width of the cell
      deleteOnDragRelease = frame.origin.x < -frame.size.width / 2.0
      completeOnDragRelease = frame.origin.x > frame.size.width / 2.0
    }
    
    if recognizer.state == .Ended {
      // original frame of cell before being dragged
      let originalFrame = CGRect(x: 0, y: frame.origin.y, width: bounds.size.width, height: bounds.size.height)
      // snap cell back to original location if item is not being deleted
      if deleteOnDragRelease {
        if delegate != nil && actionItem != nil {
          // notify delegate that the item should be deleted
          delegate!.actionItemDeleted(actionItem!)
        }
      } else if completeOnDragRelease {
          if actionItem != nil {
            actionItem!.completed = true
          }
          label.strikeThrough = true
          itemCompleteLayer.hidden = false
          UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
      } else {
          UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
      }
    }
  }
  
  // cancel vertical pans
  override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
    if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
      let translation = panGestureRecognizer.translationInView(superview!)
      // fabs() returns the absolute value of the value
      if fabs(translation.x) > fabs(translation.y) {
        return true
      }
      return false
    }
    return false
  }
  
  let kLabelLeftMargin: CGFloat = 15.0
  override func layoutSubviews() {
    super.layoutSubviews()
    // ensure cell gradient layer always occupies full bounds of the frame
    gradientLayer.frame = bounds
    itemCompleteLayer.frame = bounds
    label.frame = CGRect(x: kLabelLeftMargin, y: 0, width: bounds.size.width - kLabelLeftMargin, height: bounds.size.height)
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
