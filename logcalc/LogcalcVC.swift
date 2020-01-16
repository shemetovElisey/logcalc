//
//  ViewController.swift
//  logcalc
//
//  Created by Елисей on 12.01.2020.
//  Copyright © 2020 Longjects. All rights reserved.
//

import UIKit

class LogcalcVC: UIViewController {
    let textV = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        
        self.navigationController?.navigationBar.topItem?.title = "logcalc" // set NC title
        
        setupTextV(textV)
        hideKeyboard()
    }

    func setupTextV(_ textV: UITextView) {
        self.view.addSubview(textV)
        let key = LogKeyboard(textView: textV)
        textV.inputView = key
        textV.translatesAutoresizingMaskIntoConstraints = false
        textV.font = .boldSystemFont(ofSize: 18)
        
        NSLayoutConstraint.activate([
            textV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            textV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            textV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            textV.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            textV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            textV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            textV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            textV.heightAnchor.constraint(equalToConstant: 100)
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

