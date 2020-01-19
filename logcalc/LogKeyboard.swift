//
//  LogKeyboard.swift
//  logcalc
//
//  Created by Елисей on 13.01.2020.
//  Copyright © 2020 Longjects. All rights reserved.
//

import UIKit

class LogKeyboard: UIInputView {
    //MARK: - variables
    
    //text view
    var logText = UITextView()
    var infoText = UITextView()
    
    // stacks
    var hStackArray = [UIStackView]()
    var vStackView  = UIStackView()
    
    // variable buttons
    let xButton = CalcButton(withTitle: "x", andType: .variable, addSymbol: "x")
    let yButton = CalcButton(withTitle: "y", andType: .variable, addSymbol: "y")
    let zButton = CalcButton(withTitle: "z", andType: .variable, addSymbol: "z")
    let pButton = CalcButton(withTitle: "p", andType: .variable, addSymbol: "p")
    
    // service buttons
    let cleanButton = CalcButton(withSymbol: "delete.left", andType: .service, addSymbol: "del")
    let varButton   = CalcButton(withSymbol: "textformat.abc", andType: .service, addSymbol: "var")
    let leftButton  = CalcButton(withSymbol: "chevron.left", andType: .service, addSymbol: "lef")
    let rightButton = CalcButton(withSymbol: "chevron.right", andType: .service, addSymbol: "rig")
    let funcButton  = CalcButton(withSymbol: "function", andType: .service, addSymbol: "fun")
    
    // operation buttons
    let negationButton         = CalcButton(withSymbol: "minus", andType: .operation, addSymbol: "-")
    let shefferButton          = CalcButton(withTitle: "/", andType: .operation, addSymbol: "/")
    let peersButton            = CalcButton(withSymbol: "arrow.down", andType: .operation, addSymbol: "↓")
    let banRightButton         = CalcButton(withSymbol: "arrow.right", andType: .operation, addSymbol: "➞")
    let banLeftButton          = CalcButton(withSymbol: "arrow.left", andType: .operation, addSymbol: "←")
    let conjunctionButton      = CalcButton(withSymbol: "chevron.up", andType: .operation, addSymbol: "⋀")
    let disjunctionButton      = CalcButton(withSymbol: "chevron.down", andType: .operation, addSymbol: "⋁")
    let xorButton              = CalcButton(withSymbol: "plus.circle", andType: .operation, addSymbol: "⨁")
    let implicationRightButton = CalcButton(withSymbol: "chevron.right.2", andType: .operation, addSymbol: "⊂")
    let implicationLeftButton  = CalcButton(withSymbol: "chevron.left.2", andType: .operation, addSymbol: "⊃")
    let equivalenceButton      = CalcButton(withSymbol: "arrow.left.and.right", andType: .operation, addSymbol: "∽")
    let bracketButton          = CalcButton(withTitle: "(", andType: .operation, addSymbol: "(")
    let backBracketButton      = CalcButton(withTitle: ")", andType: .operation, addSymbol: ")")
    
    

    // MARK: - init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(textView: UITextView, infoTextView: UITextView) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 300), inputViewStyle: .keyboard)
        
        //self.backgroundColor = ProjectColors().keyboardBackground
        
        setupHStackV(forButtons: [funcButton, varButton, leftButton, rightButton, cleanButton])
        setupHStackV(forButtons: [bracketButton, backBracketButton, conjunctionButton, disjunctionButton, negationButton])
        setupHStackV(forButtons: [shefferButton, peersButton, banLeftButton, banRightButton, xorButton, equivalenceButton])
        setupHStackV(forButtons: [implicationLeftButton, xButton, yButton, zButton, pButton, implicationRightButton])
        setupVStackV(forButtons: hStackArray)
        
        self.addSubview(vStackView)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 2),
            vStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -2),
            vStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 2),
            vStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -2)
        ])
        
        logText     = textView     // add text from keyboard to text view
        infoText    = infoTextView // add information for user to
    }
    
    // MARK: - interface func
    
    func setupHStackV(forButtons buttonsArray:[CalcButton]) {
        // add targets for each button
        buttonsArray.forEach{ button in
            button.addTarget(self, action: #selector(buttonTouched(sender:)), for: .touchUpInside)
        }
        
        let hStackV = UIStackView(arrangedSubviews: buttonsArray)
        hStackV.distribution = .fillEqually
        hStackV.axis = .horizontal
        hStackV.spacing = 2
        hStackArray.append(hStackV)
    }
    
    func setupVStackV(forButtons stackVArray: [UIStackView]) {
        let vStackV = UIStackView(arrangedSubviews: stackVArray)
        vStackV.distribution = .fillEqually
        vStackV.axis = .vertical
        vStackV.spacing = 2
        vStackView = vStackV
    }
    
    //MARK: - selector
    // FIXME: - need to change the input system
    @IBAction func buttonTouched(sender: CalcButton) {
        let selectedRange = logText.selectedTextRange
        
        switch sender.getSym() {
        case "del":
            //delete action
            logText.deleteBackward()
            break
            
        case "var":
            // variable action
            break
        
        case "lef":
            // left action
            let newPosition = logText.position(from: selectedRange!.start, in: .left, offset: 1)
            logText.selectedTextRange = logText.textRange(from: newPosition!, to: newPosition!)
            break
        
        case "rig":
            // right action
            let newPosition = logText.position(from: selectedRange!.start, in: .right, offset: 1)
            logText.selectedTextRange = logText.textRange(from: newPosition!, to: newPosition!)
            break
            
        case "fun":
            // functional action
            break
            
        default:
            logText.insertText(sender.getSym()) // add symbol from keyboard to string
            break
        }
        
        UIDevice.current.playInputClick()   // click sound
        
        // checking for mistake
        if !checkForMistakes(expression: logText.text) {
            infoText.text = "Wrong expression"
        } else {
            infoText.text = ""
            let answer = LogSolver(expression: logText.text)
        }
    }
}


extension LogKeyboard {
    //MARK: - checking for mistake
    private func checkForMistakes(expression str: String) -> Bool {
        var bracketCount = 0
        var backBracketCount = 0
        var index = 0
        
        for char in str {
            index += 1
            
            // brakets counting
            if char == "(" {
                bracketCount += 1
            } else if char == ")" {
                backBracketCount += 1
            }
            
            // check for back bracket mistake
            if SymbolStruct().backBracket == String(char){
                if (SymbolStruct().bracket.contains(str[index]) || SymbolStruct().variables.contains(str[index]) || SymbolStruct().prefix.contains(str[index])) {
                    return false
                }
            }
            // check for bracket mistake
            if SymbolStruct().bracket.contains(char) {
                if (SymbolStruct().backBracket.contains(str[index]) || SymbolStruct().operations.contains(str[index])) {
                    return false
                }
            }
            
            // check for variables mistake
            if SymbolStruct().variables.contains(String(char)) {
                if (SymbolStruct().bracket.contains(str[index]) || SymbolStruct().variables.contains(str[index]) || SymbolStruct().prefix.contains(str[index])) {
                    return false
                }
            }
            
            //check for operation mistake
            if SymbolStruct().operations.contains(String(char)) {
                if (SymbolStruct().backBracket.contains(str[index]) || SymbolStruct().operations.contains(str[index])) {
                    return false
                }
            }
            
            //check for prefix mistake
            if SymbolStruct().prefix.contains(String(char)) {
                if (SymbolStruct().backBracket.contains(str[index]) || SymbolStruct().operations.contains(str[index])) {
                    return false
                }
            }
        }
        
        if bracketCount == backBracketCount {
            return true
        }
        
        return false
    }
    
}
