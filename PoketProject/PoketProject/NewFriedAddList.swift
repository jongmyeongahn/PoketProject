//
//  NewFriedAddList.swift
//  PoketProject
//
//  Created by arthur on 7/18/24.
//

import UIKit

struct NewFriedAddList: Codable {
    let sprites: [FriendAddList]
}

struct FriendAddList: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
      
    }
}
