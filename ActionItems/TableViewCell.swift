//
//  TableViewCell.swift
//  ActionItems
//
//  Created by Benjamin Shyong on 1/23/15.
//  Copyright (c) 2015 Common Sense Labs. All rights reserved.
//

import UIKit
import QuartzCore

class TableViewCell: UITableViewCell {
  
  let gradientLayer = CAGradientLayer()
 
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented. NSCoding not supported.")
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    // 4-step gradient layer for each cell
    gradientLayer.frame = bounds
    let color1 = UIColor(white: 1.0, alpha: 0.2).CGColor as CGColorRef
    let color2 = UIColor(white: 1.0, alpha: 0.1).CGColor as CGColorRef
    let color3 = UIColor.clearColor().CGColor as CGColorRef
    let color4 = UIColor(white: 0.0, alpha: 0.1).CGColor as CGColorRef
    gradientLayer.colors = [color1, color2, color3, color4]
    gradientLayer.locations = [0.0, 0.01, 0.95, 1.0]
    layer.insertSublayer(gradientLayer, atIndex: 0)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    // ensure cell gradient layer always occupies full bounds of the frame
    gradientLayer.frame = bounds
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
