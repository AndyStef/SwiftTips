//
//  StringTips.swift
//  
//
//  Created by Andy Stef on 1/9/17.
//
//

import Foundation

//The way to remove all unneccessary spaces in string
let someStringWithLotsOfSpaces = "afasfasfas     fasfasfasfasfas :: fasfasfasfs aas@@"
let trimmedString = someStringWithLotsOfSpaces.trimmingCharacters(in: .whitespacesAndNewlines)
