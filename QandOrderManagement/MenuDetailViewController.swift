//
//  MenuDetailViewController.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/12/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class MenuDetailViewController: UIViewController, UITableViewDelegate, KWStepperDelegate {
    var stepper: KWStepper?
    var menu:MenuModel?
    var lblCartCount:UILabel!
    @IBOutlet weak var btnCart:UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var txtMenuName: UITextView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnFavorite: BeefButton!
    @IBOutlet weak var btnBeefRare: BeefButton!
    @IBOutlet weak var btnBeefMediumRare: BeefButton!
    @IBOutlet weak var btnBeefMedium: BeefButton!
    @IBOutlet weak var btnBeefMediumWell: BeefButton!
    @IBOutlet weak var btnBeefWell: BeefButton!
    @IBOutlet weak var btnSidePotato: BeefButton!
    @IBOutlet weak var btnSideVegetable: BeefButton!
    @IBOutlet weak var btnSideFrenchFries: BeefButton!
    @IBOutlet weak var btnSideRice: BeefButton!
    @IBOutlet weak var btnAddToCart:UIButton!
    @IBOutlet weak var vStar:UIView!
    @IBOutlet weak var vMain:UIView!
    @IBOutlet weak var vLine1:UIView!
    @IBOutlet weak var vLine2:UIView!
    @IBOutlet weak var vLine3:UIView!
    @IBOutlet weak var vCookingSteak:UIView!
    @IBOutlet weak var vSideDisk:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        vStar.layer.cornerRadius = vStar.frame.size.width/2
        vStar.clipsToBounds = true
        vStar.layer.borderColor = UIColor.whiteColor().CGColor
        vStar.layer.borderWidth = 1.0
       // self.autoLayout()
        if menu?.menu_beef_flag == "N" {
            self.vLine1.hidden = true
            self.vCookingSteak.hidden = true
           // self.vCookingSteak = self.vSideDisk.copy() as! UIView
            self.autoLayout()
        }
        self.configureCart()
        self.configureFavorite()
        self.configureBtnBeef()
        self.configureBtnSideDisk()
        self.configureStepper()
        self.initialMenuDetail()
    }
    override func viewDidAppear(animated: Bool) {
        lblCartCount.text = "\(MyVariables.countCart)"
    }
    func autoLayout(){
        self.vMain.translatesAutoresizingMaskIntoConstraints = false
//        self.vCookingSteak.translatesAutoresizingMaskIntoConstraints = false
        self.vSideDisk.translatesAutoresizingMaskIntoConstraints = false
//        self.vLine1.translatesAutoresizingMaskIntoConstraints = false
        self.vLine2.translatesAutoresizingMaskIntoConstraints = false
        self.vLine3.translatesAutoresizingMaskIntoConstraints = false
        let viewsDict = ["vMain":self.vMain, "vCookingSteak":self.vCookingSteak, "vSideDisk":self.vSideDisk, "vLine1":self.vLine1, "vLine2":self.vLine2,"vLine3":self.vLine3,"btnAddToCart":self.btnAddToCart]
        
        let viewMetrics = ["lineWidth":self.view.frame.width,
            "lineHeight":1,
            "mainWidth":320,
            "mainHeight":245,
            "sectionWidth":320,
            "sectionHeight":90,
            "viewSpacing":0,
            "orderHeight":30,
            "orderWidth":190,
            "orderSpacing":50]
        
        // Main
        let main_constraint_width:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:[vMain(mainWidth)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: viewMetrics, views: viewsDict)
        let main_constraint_height:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[vMain(mainHeight)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: viewMetrics, views: viewsDict)
        let main_horizontal_constraint = NSLayoutConstraint( item: vMain, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        self.view.addConstraint(main_horizontal_constraint)
        self.view.addConstraints(main_constraint_width)
        self.view.addConstraints(main_constraint_height)
        
        // Line2
        let line2_constraint_height:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[vLine2(lineHeight)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: viewMetrics, views: viewsDict)
        
        let line2_constraint_position_h:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-viewSpacing-[vLine2]-viewSpacing-|", options: NSLayoutFormatOptions.AlignAllBottom, metrics: viewMetrics, views: viewsDict)
        self.view.addConstraints(line2_constraint_height)
        self.view.addConstraints(line2_constraint_position_h)
        
        // Line3
        let line3_constraint_height:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[vLine3(lineHeight)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: viewMetrics, views: viewsDict)
        let line3_constraint_position_h:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|-viewSpacing-[vLine3]-viewSpacing-|", options: NSLayoutFormatOptions.AlignAllBottom, metrics: viewMetrics, views: viewsDict)
        self.view.addConstraints(line3_constraint_height)
        self.view.addConstraints(line3_constraint_position_h)
        
        // Section2
        let section2_constraint_width:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:[vSideDisk(sectionWidth)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: viewMetrics, views: viewsDict)
        let section2_constraint_height:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[vSideDisk(sectionHeight)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: viewMetrics, views: viewsDict)
        let section2_horizontal_constraint = NSLayoutConstraint(item: vSideDisk, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        self.view.addConstraint(section2_horizontal_constraint)
        self.view.addConstraints(section2_constraint_width)
        self.view.addConstraints(section2_constraint_height)
        
        // Order Button
        let addtocart_constraint_width:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:[btnAddToCart(orderWidth)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: viewMetrics, views: viewsDict)
        let addtocart_constraint_height:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[btnAddToCart(orderHeight)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: viewMetrics, views: viewsDict)
        let addtocart_horizontal_constraint = NSLayoutConstraint(item: btnAddToCart, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        self.view.addConstraint(addtocart_horizontal_constraint)
        self.view.addConstraints(addtocart_constraint_height)
        self.view.addConstraints(addtocart_constraint_width)

        // Vertical
        let constraint_position_v:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-60-[vMain]-0-[vLine2]-0-[vSideDisk]-0-[vLine3]-orderSpacing-[btnAddToCart]", options: NSLayoutFormatOptions(rawValue: 0), metrics: viewMetrics, views: viewsDict)
        
        self.view.addConstraints(constraint_position_v)

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
    func configureFavorite(){
        if menu!.menu_favorite_flag == "Y" {
            btnFavorite.setImage(UIImage(named: "star_check"), forState: UIControlState.Normal)
            btnFavorite.tag = 1
        }else{
            btnFavorite.setImage(UIImage(named: "star_uncheck"), forState: UIControlState.Normal)
            btnFavorite.tag = 0
        }
    }
    func configureBtnBeef(){
        
        btnBeefRare.setImageAction(UIImage(named: "beef_rare1_selected"), onDeselected: UIImage(named: "beef_rare1"))
        btnBeefMediumRare.setImageAction(UIImage(named: "beef_mediumrare1_selected"), onDeselected: UIImage(named: "beef_mediumrare1"))
        btnBeefMedium.setImageAction(UIImage(named: "beef_medium1_selected"), onDeselected: UIImage(named: "beef_medium1"))
        btnBeefMediumWell.setImageAction(UIImage(named: "beef_mediumwell1_selected"), onDeselected: UIImage(named: "beef_mediumwell1"))
        btnBeefWell.setImageAction(UIImage(named: "beef_well1_selected"), onDeselected: UIImage(named: "beef_well1"))
    }
    
    func configureBtnSideDisk(){
        btnSideFrenchFries.setImageAction(UIImage(named: "side_frenchfries_selected"), onDeselected: UIImage(named: "side_frenchfries"))
        btnSidePotato.setImageAction(UIImage(named: "side_baked_potato_selected"), onDeselected: UIImage(named: "side_baked_potato"))
        btnSideVegetable.setImageAction(UIImage(named: "side_baked_vegetable_selected"), onDeselected: UIImage(named: "side_baked_vegetable"))
        btnSideRice.setImageAction(UIImage(named: "side_rice_selected"), onDeselected: UIImage(named: "side_rice"))
    }
    
    
    func initialMenuDetail(){
        imgMenu.layer.masksToBounds = true
        imgMenu.layer.cornerRadius = 10
        imgMenu.image = UIImage(named: (menu?.menu_picture)!)
        let customFont = UIFont(name: "ravenna-serial-light-regular", size: 15.0)
        txtMenuName.text = menu!.menu_name
        print("\(menu!.menu_name)")
        txtMenuName.font = customFont
        txtMenuName.textAlignment = NSTextAlignment.Center
        lblPrice.text = NSDecimalNumber(double: (menu?.menu_price)!).currency
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
            stepper.maximumValue = 20
            stepper.value = 0
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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    // MARK: - Beef Button
    @IBAction func tappedBtnBeefRare(){
        btnBeefRare.setSelectedButton(true)
        btnBeefMediumRare.setSelectedButton(false)
        btnBeefMedium.setSelectedButton(false)
        btnBeefMediumWell.setSelectedButton(false)
        btnBeefWell.setSelectedButton(false)
    }
    @IBAction func tappedBtnBeefMediumRare(){
        btnBeefRare.setSelectedButton(false)
        btnBeefMediumRare.setSelectedButton(true)
        btnBeefMedium.setSelectedButton(false)
        btnBeefMediumWell.setSelectedButton(false)
        btnBeefWell.setSelectedButton(false)
    }
    @IBAction func tappedBtnBeefMedium(){
        btnBeefRare.setSelectedButton(false)
        btnBeefMediumRare.setSelectedButton(false)
        btnBeefMedium.setSelectedButton(true)
        btnBeefMediumWell.setSelectedButton(false)
        btnBeefWell.setSelectedButton(false)
    }
    @IBAction func tappedBtnBeefMediumWell(){
        btnBeefRare.setSelectedButton(false)
        btnBeefMediumRare.setSelectedButton(false)
        btnBeefMedium.setSelectedButton(false)
        btnBeefMediumWell.setSelectedButton(true)
        btnBeefWell.setSelectedButton(false)
    }
    @IBAction func tappedBtnBeefWell(){
        btnBeefRare.setSelectedButton(false)
        btnBeefMediumRare.setSelectedButton(false)
        btnBeefMedium.setSelectedButton(false)
        btnBeefMediumWell.setSelectedButton(false)
        btnBeefWell.setSelectedButton(true)
    }
    // MARK: - Side Disk Button
    @IBAction func tappedBtnPotato(){
        btnSidePotato.setSelectedButton(true)
        btnSideFrenchFries.setSelectedButton(false)
        btnSideRice.setSelectedButton(false)
        btnSideVegetable.setSelectedButton(false)
    }
    @IBAction func tappedBtnFrenchFries(){
        btnSidePotato.setSelectedButton(false)
        btnSideFrenchFries.setSelectedButton(true)
        btnSideRice.setSelectedButton(false)
        btnSideVegetable.setSelectedButton(false)
    }
    @IBAction func tappedBtnRice(){
        btnSidePotato.setSelectedButton(false)
        btnSideFrenchFries.setSelectedButton(false)
        btnSideRice.setSelectedButton(true)
        btnSideVegetable.setSelectedButton(false)
    }
    @IBAction func tappedBtnVegetable(){
        btnSidePotato.setSelectedButton(false)
        btnSideFrenchFries.setSelectedButton(false)
        btnSideRice.setSelectedButton(false)
        btnSideVegetable.setSelectedButton(true)
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
    
    @IBAction func addToCart(sender: AnyObject) {
        
        // Animation add to cart
        let btnAddToCart = sender as! UIButton
        let startPoint = btnAddToCart.center
        let endPoint = btnCart.center
        
        let cartCountView:UIView = UIView(frame: CGRectMake(0, 0, 25, 25))
        let circleView:UIView = UIView(frame: CGRectMake(0,  0, 25, 25))
        circleView.layer.cornerRadius = circleView.frame.size.width/2
        circleView.clipsToBounds = true
        circleView.backgroundColor = UIColor(red: 121/255.0, green: 183/255.0, blue: 224/255.0, alpha: 1.0)
        cartCountView.addSubview(circleView)
        let lblCartCount:UILabel = UILabel(frame: CGRectMake(0, 0, 25, 25))
        lblCartCount.text = self.countLabel.text
        lblCartCount.font = UIFont.boldSystemFontOfSize(12)
        lblCartCount.textColor = UIColor.whiteColor()
        lblCartCount.textAlignment = .Center
        circleView.addSubview(lblCartCount)
        let cur:UIWindow? = UIApplication.sharedApplication().keyWindow
        cur?.addSubview(cartCountView)
        
        let pathAnimation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position");
        pathAnimation.calculationMode = kCAAnimationPaced;
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.removedOnCompletion = false;
        pathAnimation.duration=1;
        pathAnimation.delegate=self;
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(startPoint.x, btnAddToCart.frame.origin.y))
        path.addQuadCurveToPoint(CGPoint(x: endPoint.x+14, y: endPoint.y+btnAddToCart.frame.height/2 - 1), controlPoint: CGPoint(x:20, y:5))
        pathAnimation.path = path.CGPath
        
        // apply transform animation
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "transform")
        let transform : CATransform3D = CATransform3DMakeScale(0.25, 0.25, 0.25 ) //0.25, 0.25, 0.25);
        
        animation.setValue(NSValue(CATransform3D: transform), forKey: "transform")
        animation.duration = 1.5
        
        cartCountView.layer.addAnimation(pathAnimation, forKey: "curveAnimation")
        cartCountView.layer.addAnimation(animation, forKey: "transform")
        
        MyVariables.countCart = MyVariables.countCart + Int(self.countLabel.text!)!
        
        
        UIView.animateWithDuration(2, animations: {
            cartCountView.alpha = 0
            cartCountView.transform = CGAffineTransformMakeScale(0.7, 0.7)
            //self.setupNav.addAmountInCart(Int(self.amount.text!)!)
            }, completion: {
                finished in
                cartCountView.removeFromSuperview()
                self.lblCartCount.text = "\(MyVariables.countCart)"
                
        })
        let menuQuantity = Int(self.countLabel!.text!)
        let menuPricePerQuantity = NSDecimalNumber(double: (menu?.menu_price)!)
        let order = Order(orderMenuName: (menu?.menu_name)!, orderMenuSideDisk:"", orderQuantity:menuQuantity!, orderPrice: menuPricePerQuantity)
        MyVariables.orderList.append(order)
        
        
        /*
        // Add to cart popup
        addToCartPopupView.imgProduct.image = UIImage(named: productDetail.prod_imageArray[0].proi_image_path)
        addToCartPopupView.txtProductName.text = productDetail.prod_name
        addToCartPopupView.txtProductName.font = UIFont(name: "Century Gothic", size: 12)
        addToCartPopupView.lblQuantity.text = "\(self.amount.text!)"
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            // do your task
            dispatch_async(dispatch_get_main_queue()) {
                UIView.animateWithDuration(2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.addToCartPopupView.alpha = 1.0 }, completion: nil)
                UIView.animateWithDuration(1, delay: 3.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.addToCartPopupView.alpha = 0.0 }, completion: nil)
                
                
            }
        }
        */
        
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
