//
//  OrderViewModel.swift
//  ChihChinAssignment2022
//
//  Created by Jing on 2022/5/11.
//

import UIKit
import Combine

final class ViewModel {
    
    @Published private(set) var orders: [OrderViewModel] = []
    
    private let orderHistoryManager = OrderHistoryManager()
    private var disposables = Set<AnyCancellable>()
    
    init() {
        
        orderHistoryManager.$orders
            .sink { [weak self] value in
                guard let self = self else { return }
                self.orders = self.transfer(value)
            }
            .store(in: &disposables)
    }
    
    private func transfer(_ orders: [Order]) -> [OrderViewModel] {
        guard orders.count != 0 else { return [] }
        return orders.enumerated()
            .map { (index, order) -> OrderViewModel in
                let date = Date(timeIntervalSince1970: TimeInterval(order.T))
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss"
                let time = dateFormatter.string(from: date)
                let priceColor: UIColor = (index == 0) ? .red : (orders[index-1].p > order.p ? .red : .green )
                return OrderViewModel(time: time,
                                      price: order.p,
                                      priceColor: priceColor,
                                      amount: String(order.q))
            }
    }
    
}


struct OrderViewModel {
    let time: String
    let price: String
    let priceColor: UIColor
    let amount: String
}
