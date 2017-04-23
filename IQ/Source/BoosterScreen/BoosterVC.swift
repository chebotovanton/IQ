//
//  BoosterVC.swift
//  IQ
//
//  Created by Anton Chebotov on 22/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class BoosterVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet private weak var overlayView: UIView!
    @IBOutlet private weak var boosterSwitch: UISwitch!
    @IBOutlet private weak var refillView: UIView!
    @IBOutlet private weak var refillViewTop: NSLayoutConstraint!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var boosterLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let rec = UITapGestureRecognizer(target: self, action: #selector(BoosterVC.hide))
        overlayView.addGestureRecognizer(rec)

        boosterSwitch.onTintColor = Colors.progressColor()

        boosterLabel.text = StringUtils.boosterValue()

        refillView.layer.cornerRadius = 12
        hideRefillView()
    }

    @objc func hide() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func switchAction(sender: UISwitch) {
    }

    @IBAction func showRefillView() {
        self.refillViewTop.constant = 180.0
        UIView.animate(withDuration: 0.3) { 
            self.view.layoutIfNeeded()
        }

        textField.becomeFirstResponder()
    }

    @IBAction func hideRefillView() {
        textField.resignFirstResponder()
        self.refillViewTop.constant = self.contentView.frame.height
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    // MARK: - UITextFieldDelegate

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            StringUtils.setBoosterValue(text)
            BoosterLoader().setBoosterValue(Int(text) ?? 0)
            boosterLabel.text = StringUtils.boosterValue()
        }
    }

}
