//
//  ChartDateTransform.swift
//  iMTS
//
//  Created by VADIM KASSIN on 3/15/16.
//  Copyright © 2016 VADIM KASSIN. All rights reserved.
//

import Foundation
import ObjectMapper

public class ChartDateTransform: DateTransform {
    public typealias Object = NSDate
    public typealias JSON = Double
    
    public override func transformFromJSON(value: AnyObject?) -> NSDate? {

        if let timeStr = value as? String {
            let formatter = NSDateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "US_en")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let date = formatter.dateFromString(timeStr)
            return date
        }
        
        return nil
    }
}

