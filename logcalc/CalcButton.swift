//
//  CalcButton.swift
//  logcalc
//
//  Created by Елисей on 13.01.2020.
//  Copyright © 2020 Longjects. All rights reserved.
//

import UIKit

class CalcButton: UIButton {
    //MARK: - variables
    var typeOfButton = TypeOfButton.variable
    var symbol = ""
    
    // MARK: - init
    init(withSymbol symbol: String, andType  typeOfButton: TypeOfButton, addSymbol str: String) {
        super.init(frame: CGRect())
        
        // creating images
        let image = UIImage(systemName: symbol, withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        let bImage = image?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let gImage = image?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        
        // set the value of the button
        self.symbol = str
        
        
        self.setImage(bImage, for: .normal)
        self.setImage(gImage, for: .highlighted)
        self.typeOfButton = typeOfButton
        
        checkTypeOfButton()
    }

    init(withTitle title: String, andType  typeOfButton: TypeOfButton, addSymbol str: String) {
        super.init(frame: CGRect())
        
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.setTitleColor(.black, for: .normal)
        self.setTitleColor(.gray, for: .highlighted)
        
        self.symbol = str
        
        self.typeOfButton = typeOfButton
        
        checkTypeOfButton() // func for coloring buttons
    }
    
    init(withImage image: String, andType  typeOfButton: TypeOfButton, addSymbol str: String) {
        super.init(frame: CGRect())
        checkTypeOfButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    // func for coloring buttons
    private func checkTypeOfButton() {
        switch typeOfButton {
        case .variable:
            self.backgroundColor = ProjectColors().variable
            self.layer.cornerRadius = 5
            break
            
        case .operation:
            self.backgroundColor = ProjectColors().operation
            self.layer.cornerRadius = 5
            break
            
        case .service:
            self.backgroundColor = ProjectColors().service
            self.layer.cornerRadius = 5
            break
        }
    }
    
    // FIXME: - need to change the input system
    // input func
    public func getSym() -> String {
        return symbol
    }
}

// MARK: - Type of button enum
enum TypeOfButton {
    case variable
    case operation
    case service
}
