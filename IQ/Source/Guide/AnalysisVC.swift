//
//  AnalisysVC.swift
//  IQ
//
//  Created by Anton Chebotov on 21/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class AnalysisVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        perform(#selector(AnalysisVC.go), with: nil, afterDelay: 5.0)
    }

    @objc func go() {
        let statsVC = StatsVC(nibName: "StatsVC", bundle: nil)
        navigationController?.pushViewController(statsVC, animated: true)
    }

}
