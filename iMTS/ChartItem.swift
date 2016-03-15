//
//  ChartItem.swift
//  iMTS
//
//  Created by VADIM KASSIN on 3/15/16.
//  Copyright © 2016 VADIM KASSIN. All rights reserved.
//

import ObjectMapper

//MARK: Comparable
func ==(lhs:ChartItem, rhs:ChartItem) -> Bool {
    return lhs.date == rhs.date
}

func <(lhs:ChartItem, rhs:ChartItem) -> Bool {
    return lhs.date!.compare(rhs.date!) == NSComparisonResult.OrderedAscending
}

class ChartItem: Mappable {
    
    var high: Double?
    var low: Double?
    var open: Double?
    var close: Double?
    var instr_id: Int?
    var date:NSDate?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        
        date <- (map["date"], ChartDateTransform())
        high <- map["high"]
        low <- map["low"]
        open <- map["open"]
        close <- map["close"]
        instr_id <- map["instr_id"]
    }
}

