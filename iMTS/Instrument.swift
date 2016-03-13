//
//  Instrument.swift
//  iMTS
//
//  Created by VADIM KASSIN on 3/13/16.
//  Copyright © 2016 VADIM KASSIN. All rights reserved.
//https://github.com/tristanhimmelman/AlamofireObjectMapper
//https://github.com/Hearst-DD/ObjectMapper

import ObjectMapper

class Instrument: Mappable {

    var id: Int?
    var ticker: String?
    var bid: Double?
    var ask: Double?
    var min: Double?
    var max: Double?
    var last: Double?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        ticker <- map["ticker"]
        bid <- map["bid"]
        ask <- map["ask"]
        min <- map["min"]
        max <- map["max"]
        last <- map["last"]
    }
}
