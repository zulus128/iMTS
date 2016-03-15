//
//  FirstViewController.swift
//  iMTS
//
//  Created by VADIM KASSIN on 3/7/16.
//  Copyright © 2016 VADIM KASSIN. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class InstrumentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var instrArray = [Instrument]()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.title = "Instruments"
        timerUpdate()
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("timerUpdate"), userInfo: nil, repeats: true)
        Common.sharedInstance.instrId = 1
        Common.sharedInstance.instrName = ""
    }

    func timerUpdate() {

        Alamofire.request(.GET, instrumentsUrl)
            .responseArray("data") { (response:Response<[Instrument], NSError>) -> Void in
                
                if response.result.error == nil {
                    if let items = response.result.value {
                        self.instrArray = items
                        if items.count > 0 {
                            Common.sharedInstance.instrId = items[0].id!
                            Common.sharedInstance.instrName = items[0].ticker!
                        }
                        self.tableView.reloadData()
                    }
                }
        }
    }
    
    //MARK: UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return instrArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return 114
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:InstrumentTableViewCell = tableView.dequeueReusableCellWithIdentifier("InstrumentTableViewCell", forIndexPath: indexPath) as! InstrumentTableViewCell
        
        let instr = instrArray[indexPath.row]
        cell.tickerLabel.text = instr.ticker
        cell.bidLabel.text = "bid: " + String(instr.bid!)
        cell.askLabel.text = "ask: " + String(instr.ask!)
        cell.minLabel.text = "min: " + String(instr.min!)
        cell.maxLabel.text = "max: " + String(instr.max!)
        cell.lastLabel.text = "last: " + String(instr.last!)

        return cell
    }
    
    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    //MARK: Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "goMarketBook" {
            let destViewController = segue.destinationViewController as! MarketBookViewController
            let instr = instrArray[tableView.indexPathForSelectedRow?.row ?? 0]
            destViewController.instrId = instr.id
            Common.sharedInstance.instrId = instr.id
            Common.sharedInstance.instrName = instr.ticker
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

