//
//  ViewController.swift
//  mortgagecalculator
//
//  Created by Admin on 21/07/23.
//  Copyright © 2023 Admin. All rights reserved.
//

import UIKit

enum LoanDuration:String{
    case select = "Select a Duration"
    case fifteenYears = "15 Years"
    case thirtyYears = "30 Years"
}

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let durationOptions = [LoanDuration.select.rawValue, LoanDuration.fifteenYears.rawValue,
                           LoanDuration.thirtyYears.rawValue]
    var rateMap : [String:Double] = [:]
    
    var loanAmount: Int = 300000
    var rate:Double = 100.0
    var tenure: Int = 30*12

    @IBOutlet weak var homeValueTextEntry: UITextField!
    @IBOutlet weak var downPaymentTextEntry: UITextField!
    @IBOutlet weak var mortgageAmount: UILabel!
    @IBOutlet weak var rateAPR: UILabel!
    @IBOutlet weak var loanDurationPicker: UIPickerView!
    @IBOutlet weak var mortgageLable: UILabel!
    
    @IBAction func amtDisplay(_ sender: UIButton) {
        
        if let homeValueStr = homeValueTextEntry.text, let downPaymentStr = downPaymentTextEntry.text {
            if let homeValue = Int(homeValueStr), let downPayment = Int(downPaymentStr) {
                loanAmount = homeValue - downPayment
                mortgageAmount.text = "$\(loanAmount)"
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        populateRateMap()
        loanDurationPicker.delegate = self
        loanDurationPicker.dataSource = self
    }
    
    private func populateRateMap(){
        for duration in durationOptions {
            switch duration{
            case LoanDuration.fifteenYears.rawValue:
                rateMap[LoanDuration.fifteenYears.rawValue] = 2.75
            case LoanDuration.thirtyYears.rawValue:
                rateMap[LoanDuration.thirtyYears.rawValue] = 3.00
            default:
                rateMap[LoanDuration.select.rawValue] = 100.00
            }
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return durationOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return durationOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch durationOptions[row]{
        case LoanDuration.fifteenYears.rawValue:
            self.tenure = 15 * 12
        case LoanDuration.thirtyYears.rawValue:
            self.tenure = 30 * 12
        default:
            self.tenure = 30 * 12
        }
        if let currentRate = rateMap[durationOptions[row]]{
            self.rate = currentRate
            rateAPR.text = "\(currentRate)%"
        }
    }

    @IBAction func computeMortgage(_ sender: UIButton) {
        mortgageLable.text =  "Monthly Mortgage: $\(Mortgage().computeMortgage(collateral: self.createCollateralModel()))"
    }
    private func createCollateralModel() -> Collateral {
        return Collateral(loanDuration: self.tenure, loanAmount: self.loanAmount, rateAPR: self.rate)
    }
    
}
  
