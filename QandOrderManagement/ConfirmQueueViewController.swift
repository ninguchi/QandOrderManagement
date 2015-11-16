//
//  ConfirmQueueViewController.swift
//  QandOrderManagement
//
//  Created by Pannray Samanphanchai on 11/15/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//

import UIKit

class ConfirmQueueViewController: UIViewController {
    
    @IBOutlet weak var restaurantImage : UIImage!
    @IBOutlet weak var branchName : UILabel!
    @IBOutlet weak var branchLocation : UILabel!
    @IBOutlet weak var branchServiceTimeContact : UILabel!

    @IBOutlet weak var queueNo : UILabel!
    @IBOutlet weak var confirmCode : UILabel!
    
    
    var selectedBranch : RestaurantModel = RestaurantModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.branchName!.text = selectedBranch.res_branch_name
        self.branchLocation!.text = selectedBranch.res_address
        self.branchServiceTimeContact!.text = "Open 10:00 - 21:30 "+"Tel. "+self.selectedBranch.res_contact
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
