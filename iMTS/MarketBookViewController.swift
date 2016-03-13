//
//  MarketBookViewController.swift
//  iMTS
//
//  Created by VADIM KASSIN on 3/14/16.
//  Copyright © 2016 VADIM KASSIN. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class MarketBookViewController: UIViewController {

    var instrId:Int?
    var marketBook = [MarketBookItem]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Market Book"
        timerUpdate()
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("timerUpdate"), userInfo: nil, repeats: true)
    }

    func timerUpdate() {
        
        Alamofire.request(.GET, String(format:marketBookUrl, instrId!))
            .responseArray("data") { (response:Response<[MarketBookItem], NSError>) -> Void in
                
                if response.result.error == nil {
                    if let items = response.result.value {
                        self.marketBook = items.sort(<)
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
        
        return marketBook.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 40
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:MarketBookTableViewCell = tableView.dequeueReusableCellWithIdentifier("MarketBookTableViewCell", forIndexPath: indexPath) as! MarketBookTableViewCell
        
        let item = marketBook[indexPath.row]
        cell.priceLabel.text = String(item.price!)
        if item.buyVolume < 0.01 {
            cell.buyLabel.text = ""
            cell.sellLabel.text = String(item.sellVolume!)
            cell.sellLabel.textColor = UIColor.redColor()
            cell.priceLabel.textColor = UIColor.redColor()
        } else {
            cell.sellLabel.text = ""
            cell.buyLabel.text = String(item.buyVolume!)
            cell.buyLabel.textColor = UIColor.greenColor()
            cell.priceLabel.textColor = UIColor.greenColor()
        }
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
