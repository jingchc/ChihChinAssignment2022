//
//  TableViewCell.swift
//  ChihChinAssignment2022
//
//  Created by Jing on 2022/5/11.
//

import UIKit

class TableViewCell: UITableViewCell {
        
    var order: OrderViewModel? { didSet { updateUI() }}
    
    @IBOutlet private weak var time: UILabel!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var amount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    private func updateUI() {
        guard let o = order else {
            [time, price, amount].forEach( { $0?.text = "-"} )
            price.textColor = .gray
            return
        }        
        time.text = o.time
        price.text = o.price
        price.textColor = o.priceColor
        amount.text = o.amount
    }

}

extension UITableViewCell {
    static var reuseId: String { String(describing: Self.self) }
}
