//
//  collateral.swift
//  mortgagecalculator
//
//  Created by Admin on 21/07/23.
//  Copyright © 2023 Admin. All rights reserved.
//

import Foundation

class Collateral {
    var loanDuration: Int
    var loanAmount: Int
    var rateAPR: Double
    
    
    
    init(loanDuration: Int, loanAmount: Int, rateAPR: Double){
        self.loanAmount = loanAmount
        self.loanDuration = loanDuration
        self.rateAPR = rateAPR
    }
}
