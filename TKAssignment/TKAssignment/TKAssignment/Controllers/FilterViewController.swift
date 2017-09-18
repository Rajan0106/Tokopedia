//
//  FilterViewController.swift
//  TKAssignment
//
//  Created by Rajan Kumar Tiwari on 9/15/17.
//  Copyright © 2017 Rajan. All rights reserved.
//


import UIKit
import TagListView
import TTRangeSlider

protocol FilterViewControllerDelegate {
    func filter(with filter: Filter)
}

class FilterViewController: UITableViewController
{
    let filtersKey              =   "TokopediaFilter"
    let minimumPriceRangeKey    =   "MinimumPriceRange"
    let maximumPriceRangeKey    =   "MaximumPriceRange"
    let wholesaleKey            =   "IsWholesaleOnly"
    let goldMerchantKey         =   "IsGoldMerchantOnly"
    let officialStoreKey        =   "IsOfficialStoreOnly"

    let shopTypeSegue           =   "Shop Type Segue"
    var currentFilter: Filter?
    var filter = Filter()
    
    var delegate: FilterViewControllerDelegate?
    
    @IBOutlet weak var minimumPriceField: UITextField!
    @IBOutlet weak var maximumPriceField: UITextField!
    
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var slider: TTRangeSlider!
    @IBOutlet weak var isWholesaleSwitch:UISwitch!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let current = currentFilter {
            filter = current.mutableCopy() as! Filter
        }
        
        self.setupUI()
    }
    
    private func setupUI()
    {
        // Setting values with current filter values
        self.tagListView.textFont    =   UIFont.systemFont(ofSize: 17)
        self.tagListView.alignment   =   .left
        self.tagListView.delegate    =   self
        
        
        self.minimumPriceField.text  =   "\(Currency(value: filter.priceRange.lowerBound))"
        self.maximumPriceField.text  =   "\(Currency(value: filter.priceRange.upperBound))"
        
        self.slider.selectedMinimum  =   Float(filter.priceRange.lowerBound)
        self.slider.selectedMaximum  =   Float(filter.priceRange.upperBound)
        self.slider.delegate         =   self
        
        self.isWholesaleSwitch.isOn  =   self.filter.isWholesaleOnly
        
        if self.filter.isGoldMerchantOnly
        {
            self.tagListView.addTag(Filter.kTitleIsOfficialStore)
        }
        if self.filter.isOfficialStoreOnly
        {
            self.tagListView.addTag(Filter.kTitleIsGoldMerchant)
        }
    }
    
    private func resetUI()
    {
        // Resettings Filter components Values with initial Values
        self.minimumPriceField.text  =   "\(Currency(value: filter.priceRange.lowerBound))"
        self.maximumPriceField.text  =   "\(Currency(value: filter.priceRange.upperBound))"
        
        self.slider.selectedMinimum  =   Float(filter.priceRange.lowerBound)
        self.slider.selectedMaximum  =   Float(filter.priceRange.upperBound)
        
        self.isWholesaleSwitch.isOn  =   false
        
        self.tagListView.removeTag(Filter.kTitleIsOfficialStore)
        self.tagListView.removeTag(Filter.kTitleIsGoldMerchant)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true)
    }
    
    @IBAction func reset(_ sender: UIBarButtonItem)
    {
        self.filter.clear()
        self.resetUI()
    }
    
    @IBAction func didChangeMinimumPrice(_ sender: UITextField)
    {
        guard let text = sender.text else {
            return
        }
        guard let value = Double(text) else {
            return
        }
        self.filter.priceRange = Range<Double>(uncheckedBounds: (value, filter.priceRange.upperBound))
        self.slider.selectedMinimum = Float(value)
    }
    
    @IBAction func didChangeMaximumPrice(_ sender: UITextField)
    {
        guard let text = sender.text else {
            return
        }
        guard let value = Double(text) else {
            return
        }
        self.filter.priceRange       =   Range<Double>(uncheckedBounds: (filter.priceRange.lowerBound, value))
        self.slider.selectedMaximum  =   Float(value)
    }
    
    @IBAction func didToggleWholesale(_ sender: UISwitch)
    {
        self.filter.isWholesaleOnly  =   sender.isOn
    }
    
    @IBAction func apply(_ sender: UIBarButtonItem)
    {
        self.delegate?.filter(with: self.filter)
        self.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == shopTypeSegue {
            let shopTypeVC  =   segue.destination as! ShopTypeViewController
            shopTypeVC.isGoldMerchantOnly   =   filter.isGoldMerchantOnly
            shopTypeVC.isOfficialStoreOnly  =   filter.isOfficialStoreOnly
        }
    }
}

// MARK:- TTRangeSlider Delegate  Method
extension FilterViewController: TTRangeSliderDelegate
{
    func rangeSlider(_ sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        let minimum         =   Double(selectedMinimum)
        let maximum         =   Double(selectedMaximum)
        filter.priceRange   =   Range<Double>(uncheckedBounds: (minimum, maximum))
        
        let minPrice        =   Currency(value: minimum)
        let maxPrice        =   Currency(value: maximum)
        self.minimumPriceField.text  =   "\(minPrice)"
        self.maximumPriceField.text  =    "\(maxPrice)"
    }
}

// MARK:- ShopType ViewController Delegate Method
extension FilterViewController: ShopTypeViewControllerDelegate
{
    func didSelect(isGoldMerchantOnly: Bool, isOfficialStoreOnly: Bool)
    {
        self.filter.isGoldMerchantOnly   =   isGoldMerchantOnly
        self.filter.isOfficialStoreOnly  =   isOfficialStoreOnly
        
        var tags    =   [String]()
        if isGoldMerchantOnly
        {
            tags.append(Filter.kTitleIsGoldMerchant)
        }
        if isOfficialStoreOnly
        {
            tags.append(Filter.kTitleIsOfficialStore)
        }
        
        self.tagListView.removeAllTags()
        self.tagListView.addTags(tags)
    }
}

// MARK:- Tag List ViewDelegate Method
extension FilterViewController:TagListViewDelegate
{
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) -> Void
    {
        if title.lowercased() ==    Filter.kTitleIsGoldMerchant.lowercased()
        {
            filter.isGoldMerchantOnly       =   false
        }
        else if title.lowercased() ==    Filter.kTitleIsOfficialStore.lowercased()
        {
            filter.isOfficialStoreOnly      =   false
        }
        
        self.tagListView.removeTag(title)
    }
}
