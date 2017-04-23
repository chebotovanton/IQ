//
//  StatsVC.swift
//  IQ
//
//  Created by Anton Chebotov on 21/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class StatsVC: UIViewController {

    @IBOutlet private weak var navBarView: UIView!
    @IBOutlet private weak var bottomView: UIView!

    override func viewDidLoad() {
        navBarView.layer.shadowRadius = 16.0
        navBarView.layer.shadowOffset = CGSize(width: 0, height: 6)
        navBarView.layer.shadowColor = navBarView.backgroundColor?.cgColor
        navBarView.layer.masksToBounds = false
        navBarView.layer.shadowOpacity = 0.24

        bottomView.layer.cornerRadius = 12
        bottomView.layer.shadowRadius = 12.0
        bottomView.layer.shadowOffset = CGSize(width: 0, height: -2)
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.masksToBounds = false
        bottomView.layer.shadowOpacity = 0.18
    }

    @IBAction func close() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func howItWorks() {
        let howItWorksVC = HowItWorks(nibName: "HowItWorks", bundle: nil)
        present(howItWorksVC, animated: true, completion: nil)
    }
}
