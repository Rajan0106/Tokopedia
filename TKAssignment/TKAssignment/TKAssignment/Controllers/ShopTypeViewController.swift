//
//  ShopTypeViewController.swift
//  TKAssignment
//
//  Created by Rajan Kumar Tiwari on 9/15/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import UIKit

protocol ShopTypeViewControllerDelegate {
    func didSelect(isGoldMerchantOnly: Bool, isOfficialStoreOnly: Bool)
}

class ShopTypeViewController : UITableViewController
{
    var isGoldMerchantOnly = false {
        didSet {
            isSelected[0] = isGoldMerchantOnly
        }
    }
    var isOfficialStoreOnly = false {
        didSet {
            isSelected[1] = isOfficialStoreOnly
        }
    }
    var isSelected = [false, false]
    
    let cellIdentifier = "ShopTypeCell"
    let checkboxTag = 1
    let labelTag = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        (cell.viewWithTag(checkboxTag) as! UIImageView).image =
            isSelected[indexPath.row] ? UIImage.checkboxCheckedIcon : UIImage.checkboxIcon
        (cell.viewWithTag(labelTag) as! UILabel).text =
            (indexPath.row == 0) ? Filter.kTitleIsGoldMerchant : Filter.kTitleIsOfficialStore
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isSelected[indexPath.row] = !isSelected[indexPath.row]
        self.tableView .reloadRows(at: [indexPath], with: .automatic)
    }
}

extension ShopTypeViewController : UINavigationControllerDelegate
{
    public func navigationController(_ navigationController: UINavigationController,
                                     willShow viewController: UIViewController,
                                     animated: Bool)
    {
        if let delegateVC = viewController as? ShopTypeViewControllerDelegate {
            delegateVC.didSelect(isGoldMerchantOnly: isSelected[0], isOfficialStoreOnly: isSelected[1])
        }
    }
}













