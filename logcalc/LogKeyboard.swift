//
//  LogKeyboard.swift
//  logcalc
//
//  Created by Елисей on 13.01.2020.
//  Copyright © 2020 Longjects. All rights reserved.
//

import UIKit

class LogKeyboard: UIInputView {
    
    //text view
    var logText = UITextView()
    
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
    
    

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(textView: UITextView) {
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
        
        logText = textView // add text from keyboard to text view
    }
    
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
    
    // FIXME: - need to change the input system
    @IBAction func buttonTouched(sender: CalcButton) {
        
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
            let selectedRange = logText.selectedTextRange
            let newPosition = logText.position(from: selectedRange!.start, in: .left, offset: 1)
            logText.selectedTextRange = logText.textRange(from: newPosition!, to: newPosition!)
            break
        
        case "rig":
            // right action
            let selectedRange = logText.selectedTextRange
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
        
    }
}
