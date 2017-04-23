//
//  PurchaseDetailsVC.swift
//  IQ
//
//  Created by Anton Chebotov on 21/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class PurchaseDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var purchase: Purchase?

    @IBOutlet private weak var iconView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var progressView: ProgressView!
    @IBOutlet private weak var actionsTable: UITableView!
    @IBOutlet private weak var overlayView: UIView!

    private var items: [PurchaseAction] = []

    private let kCellIdentifier = "PurchaseDetailsCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        if let purchase = purchase {
            setup(purchase)
        }
        let rec = UITapGestureRecognizer(target: self, action: #selector(PurchaseDetailsVC.hide))
        overlayView.addGestureRecognizer(rec)

        items = createFakeItems()

        actionsTable.register(UINib(nibName: kCellIdentifier, bundle: nil), forCellReuseIdentifier: kCellIdentifier)
    }

    private func setup(_ purchase: Purchase) {
        nameLabel.text = purchase.name
        priceLabel.text = StringUtils.priceText(purchase.price, progress: purchase.progress)

        let url = URL(string: purchase.iconUrlString)
        iconView.sd_setImage(with: url)
        progressView.setup(purchase.progress)
    }

    private func createFakeItems() -> [PurchaseAction] {
        return [
            PurchaseAction(name: "WITHDRAW TO CARD", icon: UIImage(named: "withdrawIcon")!),
            PurchaseAction(name: "ADD TO BOOSTER", icon: UIImage(named: "convertIcon")!),
            PurchaseAction(name: "SEND TO FRIEND", icon: UIImage(named: "giftIcon")!)
        ]
    }

    @objc @IBAction func hide() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier)
        if let actionCell = cell as? PurchaseDetailsCell {
            let action = items[indexPath.item]
            actionCell.setup(action)
        }

        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
