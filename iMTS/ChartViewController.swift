
//
//  SecondViewController.swift
//  iMTS
//
//  Created by VADIM KASSIN on 3/7/16.
//  Copyright © 2016 VADIM KASSIN. All rights reserved.
//

import UIKit
import Charts
import Alamofire
import AlamofireObjectMapper

class ChartViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var instrLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var chartView: CandleStickChartView!
    
    var chart = [ChartItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        chartView.delegate = self
//        chartView.descriptionText = "deded"
        chartView.noDataTextDescription = "You need to provide data for the chart."
        chartView.maxVisibleValueCount = 60
        chartView.pinchZoomEnabled = true
        chartView.drawGridBackgroundEnabled = true
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .Bottom// XAxisLabelPositionBottom;
        xAxis.spaceBetweenLabels = 2
        xAxis.drawGridLinesEnabled = true
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelCount = 7
        leftAxis.drawGridLinesEnabled = true
        leftAxis.drawAxisLineEnabled = true
        
        let rightAxis = chartView.rightAxis;
        rightAxis.enabled = false
        
        chartView.legend.enabled = false
//        setDataCount(39, range: 100)
        
    }

    override func viewWillAppear(animated: Bool) {
        
        chartView.descriptionText = Common.sharedInstance.instrName!
        self.instrLabel.text = Common.sharedInstance.instrName!

        Alamofire.request(.GET, String(format:dayChartUrl, Common.sharedInstance.instrId!))
            .responseArray("data") { (response:Response<[ChartItem], NSError>) -> Void in
                
                if response.result.error == nil {
                    if let items = response.result.value {
                        self.chart = items.sort(<)
                        self.setData()
                    }
                }
        }
    }
    
    func setData() {
     
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        
        var xVals = [String]()
        for var i = 0; i < chart.count; i++ {
//            print(chart[i].date!)
            xVals.append(dateFormatter.stringFromDate(chart[i].date!))
        }
        var yVals1 = [CandleChartDataEntry]()
        
        for (var i = 0; i < chart.count; i++) {
            let c = chart[i]
            yVals1.append(CandleChartDataEntry(xIndex: i, shadowH: c.high!, shadowL: c.low!, open: c.open!, close: c.close!))
        }
        
        let set1 = CandleChartDataSet(yVals: yVals1, label: "Data Set")
        set1.axisDependency = .Left
        set1.setColor(UIColor.grayColor())
        set1.shadowColor = UIColor.darkGrayColor()
        set1.shadowWidth = 1.0
        set1.decreasingColor = UIColor.redColor()
        set1.decreasingFilled = true
        set1.increasingColor = UIColor.greenColor()
        set1.increasingFilled = false
        set1.neutralColor = UIColor.blueColor()
        
        let data = CandleChartData(xVals: xVals, dataSet: set1)
        
        chartView.data = data;
    }
    
    func setDataCount(count:Int, range:Double) {
        
        var xVals = [String]()
        for var i = 0; i < count; i++ {
            xVals.append(String(i + 1990))
        }
        var yVals1 = [CandleChartDataEntry]()
    

        for (var i = 0; i < count; i++) {
            let mult:Double = (range + 1)
            let val:Double = Double(arc4random_uniform(40)) + mult
            let high:Double = Double(arc4random_uniform(9)) + 8.0
            let low = Double(arc4random_uniform(9)) + 8.0
            let open = Double(arc4random_uniform(6)) + 1.0
            let close = Double(arc4random_uniform(6)) + 1.0
            let even = (i % 2 == 0)
            yVals1.append(CandleChartDataEntry(xIndex: i, shadowH: val + high, shadowL: val - low, open: even ? val + open : val - open, close: even ? val - close : val + close))
        }
    
        let set1 = CandleChartDataSet(yVals: yVals1, label: "Data Set")
        set1.axisDependency = .Left
        set1.setColor(UIColor.grayColor())
        set1.shadowColor = UIColor.darkGrayColor()
        set1.shadowWidth = 1.0
        set1.decreasingColor = UIColor.redColor()
        set1.decreasingFilled = true
        set1.increasingColor = UIColor.greenColor()
        set1.increasingFilled = false
        set1.neutralColor = UIColor.blueColor()
    
        let data = CandleChartData(xVals: xVals, dataSet: set1)
    
        chartView.data = data;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

