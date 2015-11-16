//
//  MenuLevel1NoQueueViewController.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/9/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class MenuLevel1NoQueueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var menuLevelTableView:UITableView!
    @IBOutlet weak var btnCart:UIButton!
    var lblCartCount:UILabel!
    let category = ["Signature Selection", "Chicken", "Seafood","Pork","Beef",  "Burger","Combination", "Kids",  "Salad",  "Appetizer", "Beverage"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCart()
        self.menuLevelTableView.delegate = self
        self.menuLevelTableView.contentInset = UIEdgeInsetsMake(-1.0, 0.0, 0.0, 0.0);
    }
    func configureCart(){
        var amount = 0
        for order in MyVariables.orderList {
            amount += order.orderQuantity
        }
        let cartCountView:UIView = UIView(frame: CGRectMake(0, 0, 18, 18))
        let circleView:UIView = UIView(frame: CGRectMake(25,  4, 18, 18))
        circleView.layer.cornerRadius = circleView.frame.size.width/2
        circleView.clipsToBounds = true
        circleView.backgroundColor = UIColor(red: 121/255.0, green: 183/255.0, blue: 224/255.0, alpha: 1.0)
        cartCountView.addSubview(circleView)
        lblCartCount = UILabel(frame: CGRectMake(0, 0, 18, 18))
        lblCartCount.text = "\(amount)"
        lblCartCount.font = UIFont.boldSystemFontOfSize(12)
        lblCartCount.textColor = UIColor.whiteColor()
        lblCartCount.textAlignment = .Center
        circleView.addSubview(lblCartCount)
        btnCart.addSubview(circleView)
    }
    
    override func viewWillAppear(animated: Bool) {
        lblCartCount.text = "\(MyVariables.countCart)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
                let menuSection1 = tableView.dequeueReusableCellWithIdentifier("favoriteCell") as! MenuLevel1Section1TableViewCell
                return menuSection1
            
        }
        else{
            let menuSection2 = tableView.dequeueReusableCellWithIdentifier("menu2Cell") as! MenuLevel1Section2TableViewCell
            print("\(category[indexPath.row])")
            menuSection2.imgCategory.image = UIImage(named: "header_\(category[indexPath.row]).jpg")
            return menuSection2
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 10 {
                performSegueWithIdentifier("drinkSegue", sender: nil)
            }else{
                performSegueWithIdentifier("categorySegue", sender: nil)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            print(category.count)
            return category.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 110
        }else{
            return 134
        }
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let menuController = MenuController()
        
        if segue.identifier == "orderSegue"{
            
        }
        else if segue.identifier == "promotionSegue" {
            let controller = segue.destinationViewController as! MenuLevel2ViewController
            let list =  menuController.getMenuByCategory("Promotion")
            print("count \(list.count)")
            controller.menuList = list
            let sectionList = menuController.getMenuSection("Promotion")
            controller.sectionList = sectionList
            controller.isFavorite = false
        }else if segue.identifier == "favoriteSegue" {
            let controller = segue.destinationViewController as! MenuLevel2ViewController
            let list =  menuController.getMenuFavorite()
            print("count \(list.count)")
            controller.menuList = list
            controller.sectionList.append("Favorite")
            controller.isFavorite = true
        }else if segue.identifier == "categorySegue"{
            let controller = segue.destinationViewController as! MenuLevel2ViewController
            let selectedPath = self.menuLevelTableView.indexPathForSelectedRow!
            let list =  menuController.getMenuByCategory(category[selectedPath.row])
            print("count \(list.count)")
            controller.menuList = list
            let sectionList = menuController.getMenuSection(category[selectedPath.row])
            controller.sectionList = sectionList
            controller.isFavorite = false
        }else if segue.identifier == "drinkSegue" {
            let controller = segue.destinationViewController as! MenuLevel2DrinkViewController
            let selectedPath = self.menuLevelTableView.indexPathForSelectedRow!
            let list =  menuController.getMenuByCategory(category[selectedPath.row])
            print("count \(list.count)")
            controller.menuList = list
            let sectionList = menuController.getMenuSection(category[selectedPath.row])
            controller.sectionList = sectionList
            controller.isFavorite = false

        }
    }
    

}
