//
//  LogSolver.swift
//  logcalc
//
//  Created by Елисей on 19.01.2020.
//  Copyright © 2020 Longjects. All rights reserved.
//

import Foundation


class LogSolver {
    var string = String()
    let letters = SymbolStruct().variables
    var numberOfVariables = Int()
    
    
    init(expression: String) {
        self.string = expression
        
        numberOfVariables = varCount(forExpr: string)
        setupLogSet(variable: numberOfVariables)
    }
    
    func varCount(forExpr string: String) -> Int {
        var numberOfVar = 0
        for letter in letters {
            if string.contains(Character(letter)) {
                numberOfVar += 1
            }
        }
        
        return numberOfVar
    }
    
    func setupLogSet(variable: Int) -> [[Bool]] {
        // that variable stores number of sets
        let numberOfElements: Int = {
            var power = 1
            for _ in 1...variable {
                power *= 2
            }
            
            return power
        }()
        
        // that variable stores binary numbers in strings
        let stringArray: [String] = {
            var arr = [String]()
            for number in 0..<numberOfElements {
                let str = String(number, radix: 2) // creating string with binary number
                let strWithZeros = String().pad(string: str, toSize: variable)
                arr.append(strWithZeros)
            }
            return arr
        }()
        
        // that variable stores binary numbers in 2d bool array
        let boolArray: [[Bool]] = {
            var arr = [[Bool]]()
            var fIndex = 0
            for str in stringArray {
                arr.append([Bool]())
                for char in str {
                    if char == "0" {
                        arr[fIndex].append(false)
                    } else {
                        arr[fIndex].append(true)
                    }
                }
                fIndex += 1
            }
            
            return arr
        }()
        
        return boolArray
    }
    
}
