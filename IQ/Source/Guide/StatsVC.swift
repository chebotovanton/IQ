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

    override func viewDidLoad() {
        navBarView.layer.shadowRadius = 16.0
        navBarView.layer.shadowOffset = CGSize(width: 0, height: 6)
        navBarView.layer.shadowColor = navBarView.backgroundColor?.cgColor
        navBarView.layer.masksToBounds = false
        navBarView.layer.shadowOpacity = 0.24
    }

    @IBAction func close() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
