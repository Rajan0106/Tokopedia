//
//  DividerView.swift
//  TKAssignment
//
//  Created by Rajan Kumar Tiwari on 9/15/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import UIKit

class DividerView: UIView
{
    @IBInspectable  var overrideColor:UIColor? {
        didSet{
            super.backgroundColor = overrideColor
        }
    }
    
    override var backgroundColor: UIColor? {
                get
                {
                    return super.backgroundColor
                }
                set
                {
                    guard let overrideColor = self.overrideColor else {
                        super.backgroundColor = .gray
                        return
                    }
                    super.backgroundColor = overrideColor
                }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = .gray
        self.setupView(withFrame:frame)
    }
   
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.setupView(withFrame: self.frame)
    }
    
    class func GetDividerView(withFrame frame: CGRect) -> DividerView
    {
        let view    = DividerView(frame:frame)
        return view
    }
    
    private func setupView(withFrame frame:CGRect)
    {
        var height:CGFloat              = frame.size.height
        if height <= 0 || height > 2
        {
            height                      = 1
            var viewFrame               = frame
            viewFrame.size.height       = height
            self.frame                  = viewFrame
        }
    }
}
