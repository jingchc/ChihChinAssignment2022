//
//  OrderModesl.swift
//  ChihChinAssignment2022
//
//  Created by Jing on 2022/5/11.
//

import Foundation

struct Order: Codable {
    let e: String   // event type
    let E: Double   // event time
    let s: String   // trade pair
    let t: Int      // trade ID
    let p: String   // price
    let q: String   // quality
    let b: Int      // buyer order ID
    let a: Int      // seller order ID
    let T: Double   // time
    let m: Bool     // ture means sell out, false means buy in
}

struct ServerOrderModel: Codable {
    let data: Order
}
