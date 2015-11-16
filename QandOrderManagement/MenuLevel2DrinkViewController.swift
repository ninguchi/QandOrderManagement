//
//  MenuLevel2DrinkTableViewController.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/14/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class MenuLevel2DrinkViewController:UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView:UIExpandableTableView!
    @IBOutlet weak var btnCart:UIButton!
    var lblCartCount:UILabel!
    var menuList : [MenuModel] = []
    var menuListBySection : [[MenuModel]?] = []
    var sectionList : [String] = []
    var isFavorite = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCart()
        if isFavorite {
            self.title = "Favorite"
            print(menuList.count)
            self.tableView.sectionOpen.append(0)
            menuListBySection.append(menuList)
            print(menuListBySection.count)
        }else{
            
            var i = 0
            for sectionName in sectionList {
                self.tableView.sectionOpen.append(i)
                let menuListBySectionTemp = menuList.filter({$0.menu_sec_name == sectionName })
                menuListBySection.append(menuListBySectionTemp)
                i++
            }
        }
        
        
        tableView.menuListBySection = menuListBySection
        
    }
    override func viewDidAppear(animated: Bool) {
        lblCartCount.text = "\(MyVariables.countCart)"
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
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 95
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (!menuListBySection.isEmpty) {
            let count = self.tableView.sectionOpen.filter({$0 == section}).count
            if count > 0 {
                return menuListBySection[section]!.count
            }
            
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuListCell", forIndexPath: indexPath) as! MenuLevel2DrinkTableViewCell
        let menuList = menuListBySection[indexPath.section]!
        let menu = menuList[indexPath.row]
        cell.txtMenuName.text = menu.menu_name
        cell.txtMenuName.font =  UIFont(name: "ravenna-serial-light-regular", size: 15)
        cell.lblMenuPrice.text = NSDecimalNumber(double: menu.menu_price).currency
        if menu.menu_favorite_flag == "Y" {
            cell.btnFavorite.setImage(UIImage(named: "star_check"), forState: UIControlState.Normal)
            cell.btnFavorite.tag = 1
        }else{
            cell.btnFavorite.setImage(UIImage(named: "star_uncheck"), forState: UIControlState.Normal)
            cell.btnFavorite.tag = 0
        }
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print("View Header in section")
        let headerView = HeaderView(tableView: self.tableView, section: section)
        headerView.backgroundColor = UIColor(red: 121/255.0, green: 183/255.0, blue: 224/255.0, alpha: 1.0)
        
        let label = UILabel(frame: headerView.frame)
        label.text = sectionList[section]
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: "ravenna-serial-medium-regular", size: 15)
        label.textColor = UIColor.whiteColor()//(red: 41.0/255.0, green: 108/255.0, blue: 163/255.0, alpha: 1.0)
        headerView.addSubview(label)
        return headerView
    }
    @IBAction func triggerFavorite(sender: AnyObject) {
        let btn = sender as! UIButton
        if btn.tag == 1 {
            btn.setImage(UIImage(named: "star_uncheck"), forState: UIControlState.Normal)
            btn.tag = 0
        }else{
            btn.setImage(UIImage(named: "star_check"), forState: UIControlState.Normal)
            btn.tag = 1
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "orderSegue" {
            
        }else {
            let controller = segue.destinationViewController as! MenuDetailViewController
            let selectedPath = self.tableView.indexPathForSelectedRow!
            let menuList = menuListBySection[selectedPath.section]!
            controller.menu = menuList[selectedPath.row]
        }
        
    }
    
}
