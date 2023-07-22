//
//  Mortgage.swift
//  mortgagecalculator
//
//  Created by Admin on 21/07/23.
//  Copyright © 2023 Admin. All rights reserved.
//

import Foundation

class Mortgage {
    public func computeMortgage(collateral: Collateral) -> Double{
        let interestRate = collateral.rateAPR/(100 * 12)
        return round((Double(collateral.loanAmount) * interestRate) / (1-pow(1/(1+interestRate), Double(collateral.loanDuration))))
    }
}
