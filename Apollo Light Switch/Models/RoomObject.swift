//
//  roomObject.swift
//  Apollo Light Switch
//
//  Created by Nick on 4/17/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit
import Foundation

class RoomObject {
    var roomName: String!
    var uuid: String!
    
    init(roomName: String, uuid: String) {
        self.roomName = roomName
        self.uuid = uuid
    }
}
