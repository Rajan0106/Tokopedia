
//
//  AlertControllerExtension.swift
//  TKAssignment
//
//  Created by Rajan Kumar Tiwari on 9/18/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import Foundation
import UIKit

typealias alertActionHandler  = ((_ action : UIAlertAction) -> Void)

extension UIAlertController
{
    class func alertControlWithTitle(_ title: String, message:String, okAlertAction:UIAlertAction?, cancelAlertAction:UIAlertAction? ) -> UIAlertController
    {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle:.alert)
        if  okAlertAction != nil
        {
            alertController.addAction(okAlertAction!)
        }
        if  cancelAlertAction != nil
        {
            alertController.addAction(cancelAlertAction!)
        }
        if  cancelAlertAction == nil &&  okAlertAction == nil
        {
            let ok = UIAlertAction(title:NSLocalizedString("Okay", comment: "Okay"), style:.default, handler:nil)
            alertController.addAction(ok)
        }
        return alertController
    }
}
