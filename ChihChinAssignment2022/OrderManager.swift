//
//  OrderManager.swift
//  ChihChinAssignment2022
//
//  Created by Jing on 2022/5/11.
//

import Foundation
import Starscream
import Combine

final class OrderHistoryManager {

    static let shared = OrderHistoryManager()
    
    @Published private(set) var orders: [Order] = []
    
    private var socket: WebSocket?
    
    init() {
        setup()
    }
    
    private func setup() {
        var request = URLRequest(url: URL(string: "wss://stream.yshyqxx.com/stream?streams=btcusdt@trade")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.respondToPingWithPong = true
        socket?.connect()
    }
    
}

extension OrderHistoryManager: WebSocketDelegate {
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
            handelText(string)
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
            // todo: return pong
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            print("cancelled")
        case .error(let error):
            print("(error)")
        }
    }
    
    private func handelText(_ s: String) {
        guard let order: ServerOrderModel = decode(s) else { return }
        if orders.count == 40 {
            var newOrders = orders
            newOrders.removeLast()
            newOrders.insert(order.data, at: 0)
            orders = newOrders
        } else {
            orders.insert(order.data, at: 0)
        }
    }
    
    private func decode<T> (_ s: String) -> T? where T: Codable {
        let decoder = JSONDecoder()
        guard let data = s.data(using: .utf8) else { return nil }
        return try? decoder.decode(T.self, from: data)
    }
}
