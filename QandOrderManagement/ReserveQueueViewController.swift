//
//  ReserveQueueViewController.swift
//  QandOrderManagement
//
//  Created by Pannray Samanphanchai on 11/11/2558 BE.
//  Copyright © 2558 Pannray Samanphanchai. All rights reserved.
//

import UIKit

class ReserveQueueViewController: UIViewController, KWStepperDelegate, contactDelegate {

    @IBOutlet weak var restaurantImage : UIImage!
    @IBOutlet weak var branchName : UILabel!
    @IBOutlet weak var branchLocation : UILabel!
    @IBOutlet weak var branchServiceTimeContact : UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    
    @IBOutlet weak var babyCarriage : UISwitch!
    @IBOutlet weak var wheelchair : UISwitch!
    @IBOutlet weak var specialRequest : UITextView!
    @IBOutlet weak var friendList : UITextView!
    
    var stepper: KWStepper?
    var selectedRestaurant : String = ""
    var selectedBranch : RestaurantModel = RestaurantModel()
    var friendArray : [String] = []
    let customFont = UIFont(name: "ravenna-serial-light-regular", size: 15.0)
    let subTitleFont = UIFont(name: "ravenna-serial-light-regular", size: 13.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup Nav
        self.navigationItem.title = self.selectedRestaurant
        self.navigationController?.navigationBar.barTintColor = UIColor(red: (41/255.0), green: (108/255.0), blue: (163/255.0), alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Heiti SC", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        var continueItem = UIBarButtonItem(title: "Continue", style: .Plain, target: self, action: "continueBtnTapped")
        
        if let font = customFont {
            continueItem.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)}
        continueItem.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = continueItem
//            self.navigationItem.hidesBackButton = true
        
    
        
        self.branchName.text = selectedBranch.res_branch_name
        self.branchLocation.text = selectedBranch.res_address
        self.branchServiceTimeContact!.text = "Open 10:00 - 21:30 "+"Tel. "+self.selectedBranch.res_contact
        
        self.babyCarriage.transform =  CGAffineTransformMakeScale(0.70, 0.70)
        self.wheelchair.transform = CGAffineTransformMakeScale(0.70, 0.70)
        self.specialRequest.font = customFont
        configureStepper()
        
        // Do any additional setup after loading the view.
    }


    func continueBtnTapped(){
        self.performSegueWithIdentifier("continueBtnTapped", sender: self)
    }

    func configureStepper() {
        self.stepper = KWStepper(
            decrementButton: self.decrementButton,
            incrementButton: self.incrementButton)
        
        if let stepper = self.stepper {
            stepper.addTarget(self,
                action: Selector("stepperDidChange"),
                forControlEvents: .ValueChanged)
            
            stepper.autoRepeat = true
            stepper.autoRepeatInterval = 0.10
            stepper.wraps = true
            stepper.minimumValue = 1
            stepper.maximumValue = 30
            stepper.value = 1
            stepper.incrementStepValue = 1
            stepper.decrementStepValue = 1
            
            stepper.delegate = self
        }
    }
    
    func stepperDidChange() {
        self.countLabel.text = NSString(format: "%.f", self.stepper!.value) as String
    }
    
    func stepperDidClampValue() {
        let stepper = self.stepper!
        let minValue = NSString(format: "%.f", stepper.minimumValue)
        let maxValue = NSString(format: "%.f", stepper.maximumValue)
        
        UIAlertView(
            title: "Stepper Limit Reached",
            message: "The step value was clamped, as it must be between \(minValue) and \(maxValue).",
            delegate: self,
            cancelButtonTitle: "OK"
            ).show()
    }
    
    // MARK: KWStepperDelegate Methods
    
    func KWStepperDidDecrement() {
        print("The stepper did decrement")
    }
    
    func KWStepperDidIncrement() {
        print("The stepper did increment")
    }
    
    func KWStepperMaxValueClamped() {
        print("Max value clamped")
        stepperDidClampValue()
    }
    
    func KWStepperMinValueClamped() {
        print("Min value clamped")
        stepperDidClampValue()
    }


    @IBAction func displayAlert(){
        let alertController = UIAlertController(title: "", message: "Application would like to access your contacts?", preferredStyle: .Alert)
        
        let dontAllowAction = UIAlertAction(title: "Don't Allow", style: .Default, handler: nil)
        let allowAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            self.performSegueWithIdentifier("addfriend", sender: self)
        }
        
        alertController.addAction(dontAllowAction)
        alertController.addAction(allowAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
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
        
        if(segue.identifier == "addfriend"){
            print("ADD FRIEND SEGUE")
            let controller = segue.destinationViewController as! ContactListTableViewController
            controller.delegate = self
        }else if(segue.identifier == "continueBtnTapped"){
            let confirmQueueController = segue.destinationViewController as! ConfirmQueueViewController
            confirmQueueController.selectedBranch = self.selectedBranch
        }
        
    }
    
    
    func backToReservePage(contactList:[String]){
        print("2")
        
        var friend : String = ""
        for i in 0..<contactList.count {
            friend = friend + contactList[i] + "\r\n"
        }
        self.friendList.font = subTitleFont
        self.friendList.text = friend
    }
    

}
