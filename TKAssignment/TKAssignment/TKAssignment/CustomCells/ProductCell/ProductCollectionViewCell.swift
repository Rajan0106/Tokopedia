//
//  ProductCollectionViewCell.swift
//  TKAssignment
//
//  Created by Rajan Kumar Tiwari on 9/16/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


class ProductCollectionViewCell: UICollectionViewCell
{
    static let reuseIdenitifier =   "ProductCollectionViewCell"
    static let nibName          =   "ProductCollectionViewCell"
    
    @IBOutlet weak var rightDividerView: DividerView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.productImageView.layer.cornerRadius    =   3.0
        self.productImageView.layer.masksToBounds   =   true
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        self.productImageView.image         =   nil
        self.rightDividerView.isHidden      =   false
    }
    
    func prepareCellWithProduct(_ product: Product?, atIndexPath indexPath: IndexPath)
    {
        guard let product = product else {
            return
        }
        
        self.productNameLabel.text          =   product.name
        self.productImageView.kf.setImage(with: product.thumbnailUri, placeholder: UIImage.tokopediaDefaultIcon, options: nil, progressBlock: nil)
        if let price = product.price
        {
            self.productPriceLabel.text     =   price.description
        }
    }
}
