//
//  ProductListViewController.swift
//  TKAssignment
//
//  Created by Rajan Kumar Tiwari on 9/15/17.
//  Copyright © 2017 Rajan. All rights reserved.
//

import UIKit
import SwiftyBeaver

class ProductListViewController: UIViewController
{
    let filterSegue = "Filter Segue"
    /// Specifies the number of count of row in Api Call.
    let countOfDataToBeFetchedOnce:Int  =   10
    let server                          =   LiveServer()
    
    var startIndex:Int                  =   0
    var productList: [Product]          =   [Product]()
    
    var filter = Filter()
    
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    private func setupUI()
    {
        self.productListCollectionView.register(UINib.init(nibName: ProductCollectionViewCell.nibName, bundle:nil),
                                                forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdenitifier)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupUI()
        self.addInfiniteScrollingToCollectionView()
        self.makeNetworkCall()
    }
    
    /// Use this method to do  Networking call
    fileprivate func makeNetworkCall()
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible  = true
        server.products(from: startIndex, count: countOfDataToBeFetchedOnce, filter: self.filter) {[weak self] products in
             UIApplication.shared.isNetworkActivityIndicatorVisible  = false
            guard let productsList = products, productsList.isEmpty == false else {
                
                var message     =   ""
                if products == nil // Error happened
                {
                    message     =   NSLocalizedString("Oops something went wrong, Please try again.", comment: "")
                }
                else if products?.isEmpty == true // data not found with current filter
                {
                    message     =   NSLocalizedString("Products not found for current filter, Please try with another.", comment: "")
                }
                let alertController = UIAlertController.alertControlWithTitle(NSLocalizedString("Error!", comment:""), message: message, okAlertAction: nil, cancelAlertAction:nil)
                self?.present(alertController, animated: true, completion:nil)
                
                SwiftyBeaver.debug("No data found", context: "Product list")
                
                //SHOW ALERT IF DATa is not found
                return
            }
            self?.startIndex +=  productsList.count
            self?.productList.append(contentsOf: productsList)
            self?.productListCollectionView.reloadData()
            
            // stop collection view infinite Scrolling if calls initiated from bottom
            self?.productListCollectionView.infiniteScrollingView.stopAnimating()
        }
    }
    
    private func addInfiniteScrollingToCollectionView()
    {
        self.productListCollectionView.addInfiniteScrolling {
            self.makeNetworkCall()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == filterSegue else {
            return
        }
        guard let navController = segue.destination as? UINavigationController else {
            return
        }
        guard let filterVC = navController.viewControllers.first as? FilterViewController else {
            return
        }
        
        filterVC.currentFilter = filter
        filterVC.delegate = self
    }
}

extension ProductListViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: (self.view.frame.size.width - 0) / 2, height: 250.0)
    }
    
    ///return number of sections in collection view
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    /// tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count 
    }
    
    /// make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdenitifier, for: indexPath as IndexPath) as? ProductCollectionViewCell else {
            fatalError("Unexpected Index Path")
        }
        let product = productList[indexPath.row]
        cell.prepareCellWithProduct(product, atIndexPath: indexPath)

        return cell
    }
}

extension ProductListViewController : FilterViewControllerDelegate
{
    func filter(with filter: Filter)
    {
        self.filter         =   filter
        self.startIndex     =   0
        
        self.productList.removeAll()
        self.makeNetworkCall()
    }
}
