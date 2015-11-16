//
//  BranchListViewController.swift
//  QandOrderManagement
//
//  Created by Pannray Samanphanchai on 11/7/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//

import UIKit

class BranchListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbvBranch : UITableView!
    var selectedRestaurant : String = ""
    let headerFont = UIFont(name: "ravenna-serial-medium-regular", size: 15.0)
    let customFont = UIFont(name: "ravenna-serial-light-regular", size: 15.0)
    
    var selectedBranchIndex : NSIndexPath = NSIndexPath()
    var branchArray : [RestaurantModel] = []
    var branchFavouriteArray : [RestaurantModel] = []
    
//    var branchFavouriteArray : [String] = ["Central Plaza Ladprao", "Siam Center"]
//    var branchArray : [String] = ["Siam Center", "Siam One", "Central World", "Central Ladprao"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Navigation
        self.navigationItem.title = self.selectedRestaurant
        self.navigationController?.navigationBar.barTintColor = UIColor(red: (41/255.0), green: (108/255.0), blue: (163/255.0), alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Heiti SC", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.tbvBranch.rowHeight = 35.0
        
        //Get BranchList
        self.branchArray = RestaurantController().getAllRestaurant()
        self.branchFavouriteArray.append(branchArray[4])
        self.branchFavouriteArray.append(branchArray[20])
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedBranchIndex = indexPath
        self.performSegueWithIdentifier("selectedbranch", sender: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if(tableView.ta
        if(section == 0){
            return branchFavouriteArray.count
        }else{
            return branchArray.count
        }
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Favourite"
        }else{
            return "Nearby"
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! BranchTableViewCell!
        
        
        if(indexPath.section == 0){
            cell.favButton.setImage(UIImage(named: "star_check.png"), forState: UIControlState.Normal)
            cell.favButton.addTarget(self, action: "setFavourite:", forControlEvents: UIControlEvents.TouchUpInside)
//            cell.branchLabel.text = branchFavouriteArray[indexPath.row]
            cell.branchLabel.text = branchFavouriteArray[indexPath.row].res_branch_name
            
        }else{
            
            cell.favButton.setImage(UIImage(named: "star_uncheck.png"), forState: UIControlState.Normal)
            cell.favButton.addTarget(self, action: "setFavourite:", forControlEvents: UIControlEvents.TouchUpInside)
//            cell.branchLabel.text = branchArray[indexPath.row]
            cell.branchLabel.text = branchArray[indexPath.row].res_branch_name
            
        }
        
        return cell
    }
    
    func setFavourite(sender: AnyObject){
        var button = sender as! UIButton
        
        let clickedCell  = button.superview?.superview as! UITableViewCell
        let indexPath = self.tbvBranch.indexPathForCell(clickedCell) as NSIndexPath?
        
        if(indexPath!.section == 0){ //Set to unFavourite
            self.branchFavouriteArray.removeAtIndex(indexPath!.row)
            
        }else{  //Set to Favourite
            //Check Available
            let obj = self.branchArray[indexPath!.row]
            var dup : Bool = false
            for i in 0..<(self.branchFavouriteArray.count) {
                if(obj.res_branch_name == self.branchFavouriteArray[i].res_branch_name){
                    dup = true
                }
            }
            
            if(!dup){
                self.branchFavouriteArray.append(obj)
            }
            
        }
        
        self.tbvBranch.reloadData()
        
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        var headerLabel = ""
        if(section == 0){
            headerLabel = "Favourite"
        }else{
            headerLabel = "Nearby"
        }
        
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel!.text = headerLabel
        header.textLabel!.font = headerFont
        header.textLabel!.textColor = UIColor.whiteColor()
        header.textLabel!.textAlignment = NSTextAlignment.Left
        header.backgroundView?.backgroundColor = UIColor(red: 121/255, green: 183/255, blue: 224/255, alpha: 1.0)
        

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "selectedbranch") {
            let currentQueueViewController = segue.destinationViewController as! CurrentQueueViewController
            currentQueueViewController.selectedRestaurant = self.selectedRestaurant
            if(selectedBranchIndex.section == 0){
                //Fav
                currentQueueViewController.selectedBranch = self.branchFavouriteArray[selectedBranchIndex.row]
                
            }else{
                //Not Fav
                currentQueueViewController.selectedBranch = self.branchArray[selectedBranchIndex.row]
            }
            
        }
    }
    

}
