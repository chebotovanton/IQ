//
//  PurchaseDetailsVC.swift
//  IQ
//
//  Created by Anton Chebotov on 21/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class PurchaseDetailsVC: UIViewController { //, UITableViewDelegate, UITableViewDataSource {

    var purchase: Purchase?

    @IBOutlet private weak var iconView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var progressView: ProgressView!
    @IBOutlet private weak var actionsTable: UITableView!

    private var items: [PurchaseAction] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if let purchase = purchase {
            setup(purchase)
        }
        let rec = UITapGestureRecognizer(target: self, action: #selector(PurchaseDetailsVC.hide))
        view.addGestureRecognizer(rec)
    }

    private func setup(_ purchase: Purchase) {
        nameLabel.text = purchase.name
        priceLabel.text = StringUtils.priceText(purchase.price, progress: purchase.progress)
        iconView.image = purchase.icon
        progressView.setup(purchase.progress)
    }

    @objc @IBAction func hide() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
