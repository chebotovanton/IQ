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
    @IBOutlet private weak var boosterSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        let rec = UITapGestureRecognizer(target: self, action: #selector(BoosterVC.hide))
        overlayView.addGestureRecognizer(rec)

        boosterSwitch.onTintColor = Colors.progressColor()
    }

    @objc @IBAction func hide() {
        dismiss(animated: true, completion: nil)
    }

    @objc @IBAction func switchAction(sender: UISwitch) {
    }
}
