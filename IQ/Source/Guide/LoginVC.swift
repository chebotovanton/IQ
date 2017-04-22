//
//  LoginVC.swift
//  IQ
//
//  Created by Anton Chebotov on 21/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = nextButton.frame.height / 2.0
        nextButton.clipsToBounds = true
    }

    @IBAction func go() {
        let analysisVC = AnalysisVC(nibName: "AnalysisVC", bundle: nil)
        navigationController?.pushViewController(analysisVC, animated: true)
    }

    // MARk: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginField {
            passwordField.becomeFirstResponder()
        } else {
            go()
        }

        return true
    }
}
