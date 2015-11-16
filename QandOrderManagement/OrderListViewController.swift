//
//  OrderListViewController.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/14/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class OrderListViewController: UIViewController, UITableViewDataSource, changeQuantityValueDelegate {
    let orderList = MyVariables.orderList
    @IBOutlet weak var lblTotalPrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reCalculate()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyVariables.orderList.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("cell for row")
        let cell = tableView.dequeueReusableCellWithIdentifier("orderCell", forIndexPath: indexPath) as! OrderTableViewCell
        cell.delegate = self
        cell.setCountValue(MyVariables.orderList[indexPath.row], index: indexPath.row)
        cell.txtMenuName.text  = MyVariables.orderList[indexPath.row].orderMenuName
        cell.txtMenuName.font =  UIFont(name: "ravenna-serial-light-regular", size: 15)
        //cell.lblMenuName.text = MyVariables.orderList[indexPath.row].orderMenuName
        cell.lblPrice.text = MyVariables.orderList[indexPath.row].orderPrice.decimalNumberByMultiplyingBy(NSDecimalNumber(integer: MyVariables.orderList[indexPath.row].orderQuantity)).currency
        cell.lblCount.text = "\(MyVariables.orderList[indexPath.row].orderQuantity)"
        return cell
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            MyVariables.orderList.removeAtIndex(indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
            tableView.endUpdates()

        }
    }
    func reCalculate(){
        print("recalculate")
        var grandTotal:NSDecimalNumber = 0
        
        for order in MyVariables.orderList {
            let quantity = NSDecimalNumber(integer: order.orderQuantity)
            let totalPrice = quantity.decimalNumberByMultiplyingBy(order.orderPrice)
            grandTotal = grandTotal.decimalNumberByAdding(totalPrice)
        }
        self.lblTotalPrice.text = grandTotal.currency
    }
    
    override func viewDidDisappear(animated: Bool) {
        var quantity = 0
        for order in MyVariables.orderList {
            quantity += order.orderQuantity
        }
        print("Quantity : \(quantity)")
        MyVariables.countCart = quantity
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
