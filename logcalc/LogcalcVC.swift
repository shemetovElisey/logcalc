//
//  ViewController.swift
//  logcalc
//
//  Created by Елисей on 12.01.2020.
//  Copyright © 2020 Longjects. All rights reserved.
//

import UIKit

class LogcalcVC: UIViewController {
    // MARK: - variables
    
    // text views
    let textV = UITextView()
    let infoTextV = UITextView()
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = ProjectColors().vcBackground
        
        self.navigationController?.navigationBar.topItem?.title = "logcalc" // set NC title
        
        setupTextV()
        hideKeyboard()
    }

    // MARK: - interface func
    func setupTextV() {
        self.view.addSubview(textV)
        self.view.addSubview(infoTextV)
        
        let key = LogKeyboard(textView: textV, infoTextView: infoTextV) // create keyboard
        
        // customise text view
        textV.inputView = key
        textV.translatesAutoresizingMaskIntoConstraints = false
        textV.font = .boldSystemFont(ofSize: 18)
        
        // customise info text view
        infoTextV.translatesAutoresizingMaskIntoConstraints = false
        infoTextV.isUserInteractionEnabled = false
        infoTextV.font = .boldSystemFont(ofSize: 18)
        infoTextV.backgroundColor = ProjectColors().vcBackground
        
        // activating constraints
        NSLayoutConstraint.activate([
            textV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            textV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            textV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            textV.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            infoTextV.topAnchor.constraint(equalTo: textV.bottomAnchor, constant: 0),
            infoTextV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            infoTextV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            infoTextV.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - dismiss keyboard
    private func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)

    }
}

