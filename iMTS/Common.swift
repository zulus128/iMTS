//
//  Common.swift
//  iMTS
//
//  Created by VADIM KASSIN on 3/13/16.
//  Copyright © 2016 VADIM KASSIN. All rights reserved.
//

import UIKit

let serverUrl = "http://127.0.0.1:3000"
let instrumentsUrl = serverUrl + "/api/instruments"

class Common: NSObject {

    override init() {
        
    }
    
    class var sharedInstance : Common {
        
        struct Static {
            
            static let instance : Common = Common()
        }
        
        return Static.instance
    }
}
