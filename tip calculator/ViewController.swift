//
//  ViewController.swift
//  tip calculator
//
//  Created by Angela Qian on 9/8/20.
//  Copyright © 2020 Angela Qian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var splitStepper: UIStepper!
    
    @IBOutlet weak var splitNumLabel: UILabel!
    @IBOutlet weak var eachLabel: UILabel!
    @IBOutlet weak var animatedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.animatedView.alpha = 0.0
        billField.becomeFirstResponder()
        tipLabel.text = convertDoubleToCurrency(amount: 0.0)
        totalLabel.text = convertDoubleToCurrency(amount: 0.0)
        eachLabel.text = convertDoubleToCurrency(amount: 0.0)
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
//    @IBAction func animate(_ sender: Any) {
//        print("animate")
//        UIView.animate(withDuration: 1.5, delay: 1.0, options: [.autoreverse,.repeat], animations: {
//            self.animatedView.alpha = 1.0
//        })
//    }
    
    @IBAction func calculateTip(_ sender: Any) {
        //get bill
        let bill = Double(billField.text!) ?? 0
        
        //calculate tip and total
        let tipPercentages = [0.15,0.18,0.2]
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = Double(bill + tip)
        //update tip and total labels
        
        tipLabel.text = convertDoubleToCurrency(amount: tip)
        //totalLabel.text = String(format: "$%.2f", total)
        totalLabel.text = convertDoubleToCurrency(amount: total)
        
        //update each label based on split
        let split = Int(splitStepper.value)
        if (split == 0) {
            splitNumLabel.text = "Split with no one"
        } else if (split == 1) {
            splitNumLabel.text = "Split with 1 person"
        } else {
        splitNumLabel.text = "Split with " + String(split) + " people"
        }
        
        let each = total / Double(split + 1)
        eachLabel.text =  convertDoubleToCurrency(amount: each)
        
        UIView.animate(withDuration: 1.5, delay: 1.0, options: [.autoreverse,.repeat], animations: {
            self.animatedView.alpha = 1.0
        })
    }
    
    func convertDoubleToCurrency(amount: Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        numberFormatter.minimumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: amount))!
    }

    
}

