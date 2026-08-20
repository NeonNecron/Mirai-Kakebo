//
//  Item.swift
//  Mirai_Kakebo
//
//  Created by Bruno Leal Villarreal on 20/08/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
