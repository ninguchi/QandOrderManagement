//
//  CurrentQueueViewController.swift
//  QandOrderManagement
//
//  Created by Pannray Samanphanchai on 11/8/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//

import UIKit

class CurrentQueueViewController: UIViewController {
    
    @IBOutlet weak var restaurantImage : UIImage!
    @IBOutlet weak var branchName : UILabel!
    @IBOutlet weak var branchLocation : UILabel!
    @IBOutlet weak var branchServiceTimeContact : UILabel!
    
    var selectedRestaurant : String = ""
    var selectedBranch : RestaurantModel = RestaurantModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup Nav
        self.navigationItem.title = self.selectedRestaurant
        self.navigationController?.navigationBar.barTintColor = UIColor(red: (41/255.0), green: (108/255.0), blue: (163/255.0), alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Heiti SC", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.branchName!.text = self.selectedBranch.res_branch_name
        self.branchLocation!.text = self.selectedBranch.res_address
        self.branchServiceTimeContact!.text = "Open 10:00 - 21:30 "+"Tel. "+self.selectedBranch.res_contact
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "reserveQueue"){
            let reserveQueueViewController = segue.destinationViewController as! ReserveQueueViewController
            reserveQueueViewController.selectedBranch = self.selectedBranch
            reserveQueueViewController.selectedRestaurant = self.selectedRestaurant
        }
        
    }
    
}
