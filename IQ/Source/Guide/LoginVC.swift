//
//  LoginVC.swift
//  IQ
//
//  Created by Anton Chebotov on 21/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var loginField: UITextField?
    @IBOutlet weak var passwordField: UITextField?

    @IBAction func go() {
        let analysisVC = AnalysisVC(nibName: "AnalysisVC", bundle: nil)
        navigationController?.pushViewController(analysisVC, animated: true)
    }
}
