//
//  OrderTableViewCell.swift
//  Queue
//
//  Created by Kewalin Sakawattananon on 11/14/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

protocol changeQuantityValueDelegate{
    func reCalculate()
}

class OrderTableViewCell: UITableViewCell, KWStepperDelegate {
    @IBOutlet weak var lblMenuName:UILabel!
    @IBOutlet weak var lblPrice:UILabel!
    @IBOutlet weak var lblCount:UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var txtMenuName:UITextView!
    var stepper: KWStepper?
    var order : Order?
    var index : Int?
    var delegate:changeQuantityValueDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.configureStepper()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
            
            stepper.incrementStepValue = 1
            stepper.decrementStepValue = 1
            
            stepper.delegate = self
        }
    }
    func setCountValue(order:Order, index: Int){
        self.order = order
        self.index = index
        stepper!.value =  Double(order.orderQuantity)
    }
    func stepperDidChange() {
        print("inner : recalculate")
        self.lblCount.text = NSString(format: "%.f", self.stepper!.value) as String
        order!.orderQuantity = Int((self.stepper?.value)!)
        MyVariables.orderList[index!] = order!
        self.lblPrice.text = order!.orderPrice.decimalNumberByMultiplyingBy(NSDecimalNumber(integer: order!.orderQuantity)).currency
        
        delegate?.reCalculate()
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


}
