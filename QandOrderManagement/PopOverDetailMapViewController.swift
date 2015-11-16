//
//  PopOverDetailMapTableViewController.swift
//  ExpertTech
//
//  Created by Kewalin Sakawattananon on 8/14/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class PopOverDetailMapViewController: UIViewController {
    
    @IBOutlet weak var btnView:UIButton!
    @IBOutlet weak var lblBranchName:UILabel!
    @IBOutlet weak var txtAddress:UITextView!
    var resId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnView.layer.cornerRadius = 5.0
        if let res_id = Int32(resId){
            let res = RestaurantController().getRestaurantById(res_id)
            lblBranchName.text = res.res_branch_name
            txtAddress.text = res.res_address
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSelectedDetail(sender: AnyObject) {
        print("on select detail")
    }
}
