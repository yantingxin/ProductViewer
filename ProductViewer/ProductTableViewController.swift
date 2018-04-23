//
//  ProductTableViewController.swift
//  ProductViewer
//
//  Created by Terry Yan on 4/20/18.
//  Copyright © 2018 Terry Yan. All rights reserved.
//

import UIKit

class ProductTableViewController: UITableViewController {

    var productArray = [Product]()
    var productModel = ProductModel()
    
    private func updateProducts(products: [Product]?) {
        print("Updating UI: current size = \(productArray.count)")
        DispatchQueue.main.async {
            var index = self.productArray.count
            var indexPaths = [IndexPath]()
            for product in products! {
                self.productArray.append(product)
                let indexPath = IndexPath(item: index, section: 0)
                indexPaths.append(indexPath)
                index += 1
            }
            UIView.setAnimationsEnabled(false)
            self.tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.none)
        }
    }
    
    private func updateImage(index: Int, image: UIImage?) {
        self.productArray[index].setImage(image: image!)
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: index, section: 0)
            UIView.setAnimationsEnabled(false)
            self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        productModel.fetchProduct(completionHandler: updateProducts)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ProductTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProductTableViewCell else {
            fatalError("The dequeued cell is not an instance of ProductTableViewCell.")
        }
        
        let product = productArray[indexPath.row]
        
        cell.nameLabel.text = product.name
        cell.priceLabel.text  = String("$\(product.price.format(format: ".2"))")
        cell.ratingView.setRating(rating: Int(round(product.review)))
        cell.countLabel.text = String("(\(product.reviewCount))")
        
        if product.status {
            cell.statusLabel.text = "In stock"
            cell.statusLabel.textColor = brightBlue

        } else {
            cell.statusLabel.text = "Out of stock"
            cell.statusLabel.textColor = UIColor.red
        }
        
        if product.image == nil {
            cell.productImage?.image = UIImage(named: "default")
            productModel.fetchImage(url: product.imageUrl, index: indexPath.row, completionHandler: updateImage)
        } else {
            cell.productImage?.image = product.image
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue" {
            let destination = segue.destination as! ProductDetailViewController
            let index = self.tableView.indexPathForSelectedRow?.row
            destination.products = productArray
            destination.currentIndex = index
            destination.productModel = productModel
        }
    }
 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
