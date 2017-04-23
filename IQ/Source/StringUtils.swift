//
//  StringUtils.swift
//  IQ
//
//  Created by Anton Chebotov on 21/04/2017.
//  Copyright © 2017 Anton Chebotov. All rights reserved.
//

import UIKit

class StringUtils: NSObject {

    static let kAuthKey = "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXUyJ9.eyJ1c2VybmFtZSI6InNhbXZlbC5nZXZvcmdpYW4iLCJpYXQiOiIxNDkyODk5MTMxIn0.ebomvIZfWT2Te9PI2828mDMpve19hHf5vx4z3H0JgiSUL-L3eFt_-TCiUfTYawE7vpK90cKyqivObZP46A-5SX7EPfoZq9ZC9Iatub_KVI6iEHh1L84PemGbHj3-JkApBY9hZPAKyZ7rrelAvGRd5Qg8ux0wewf-OfaWwFHPeDAnqPrH_jVpTOBNcwROtTE1CspZI3L_vCDJuS4hToBNg7wslU6a_Vif19mug2S3leOQCSeC-9Ts7p-6E8HsjWbPzjfmno0C7OhSSInsfwqIIcmMdDp10tTc3KUsg485Y2TKfnzjMf0HKafp4l3QL4MTwa-Cy6LA3rv8vz6VHwDf3uuv34XeegnlTlxR_J1ho4fmeNfzEeM4vTWZm289-oGnjbzBGUdkP5NzARpQs22N5ZWFVW8NoSCyrda5MIiud4LBdrwvOZ8Rpw8M-OnVjb-XOqzBLZEmMQxmzbNKEbOPJhBasv3sG9GniWWGGWJpJwjfmT_0TSueeO_ki9FrxaVAqG_Kj3KT1mtJJXUQwpG1CiuXfASzO4ie5aaVs_x969YlioYlxy0QUDmi6gLuHeSaZRdoC1dNhzJ84WcAYKybH7yzZXAvt2Y5SPyvEZF4s3IiBGs-t9csUZxxYMmoULR62USQ0PGNBhdm3DxbpMsB6jspxZ-fQzsDilQlGzEhRmg"

    static let kBaseUrl = "http://ec2-34-200-221-62.compute-1.amazonaws.com"

    static let kBoosterKey = "boosterKey"

    static func boosterValue() -> String {
        let string = UserDefaults.standard.string(forKey: kBoosterKey) ?? "0"
        return "$" + string
    }

    static func setBoosterValue(_ boosterValue: String) {
        UserDefaults.standard.set(boosterValue, forKey: kBoosterKey)
    }

    static func priceText(_ price: Int, progress: CGFloat) -> String {
        if progress == 0 || progress == 1  {
            return "$" + String(price)
        } else {
            let currentValue = Int(CGFloat(price) * progress)
            return "$" + String(currentValue) + " / " + "$" + String(price)
        }
    }

}
