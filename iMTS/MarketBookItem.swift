//
//  MarketBookItem.swift
//  iMTS
//
//  Created by VADIM KASSIN on 3/14/16.
//  Copyright © 2016 VADIM KASSIN. All rights reserved.
//

import ObjectMapper

//MARK: Comparable
func ==(lhs:MarketBookItem, rhs:MarketBookItem) -> Bool {
    return lhs.price == rhs.price
}

func <(lhs:MarketBookItem, rhs:MarketBookItem) -> Bool {
    return lhs.price < rhs.price
}

class MarketBookItem: Mappable, Comparable {

    var instrId: Int?
    var sellVolume: Double?
    var buyVolume: Double?
    var price: Double?

    required init?(_ map: Map){
        
    }
    
    //MARK: Mappable
    func mapping(map: Map) {
        
        instrId <- map["instr_id"]
        sellVolume <- map["sell_volume"]
        buyVolume <- map["buy_volume"]
        price <- map["price"]
    }

}
