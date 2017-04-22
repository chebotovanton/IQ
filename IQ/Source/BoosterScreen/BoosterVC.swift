//
//  BoosterVC.swift
//  IQ
//
//  Created by Anton Chebotov on 22/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class BoosterVC: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet private weak var overlayView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let rec = UITapGestureRecognizer(target: self, action: #selector(BoosterVC.hide))
        overlayView.addGestureRecognizer(rec)
    }


    @objc @IBAction func hide() {
        dismiss(animated: true, completion: nil)
    }

}
