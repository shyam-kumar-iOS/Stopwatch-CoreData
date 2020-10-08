//
//  StopWatchViewController.swift
//  ZydeSolutionsTask
//
//  Created by Shyam Kumar on 9/30/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class StopWatchViewController: UIViewController, StopwatchDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var minutesLbl: UILabel!
    
    @IBOutlet weak var secLbl: UILabel!
    
    @IBOutlet weak var milliSecLbl: UILabel!
    
    @IBOutlet weak var lapBtn: UIButton!
    
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var lapTblV: UITableView!
    
    private var watch: Stopwatch!
      
    @IBOutlet weak var timeLbl: UILabel!
   
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           watch = Stopwatch(delegate: self)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationItem.title = "Stopwatch"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        lapTblV.rowHeight = UITableView.automaticDimension
        initializeTimerUI()
        lapTblV.delegate = self
        lapTblV.dataSource = self
               
        timeLbl.font = UIFont.monospacedDigitSystemFont(ofSize: 70, weight: UIFont.Weight.regular)
        startBtn.setBackgroundImage(UIImage(named: "start") as UIImage?, for: .normal)
        lapBtn.setBackgroundImage(UIImage(named: "lapFade") as UIImage?, for: .normal)
        
    }
    
    func currentTimerUpdated(seconds: String, minutes: String, milliseconds: String) {

        timeLbl.text = "\(minutes) : \(seconds) : \(milliseconds) "
    
        lapTblV.isScrollEnabled = false
      
        self.lapTblV.reloadData()
        
        
    }
    
    func timerHasStarted() {
      
       startBtn.setBackgroundImage(UIImage(named: "stop") as UIImage?, for: .normal)
       
       lapBtn.setBackgroundImage(UIImage(named: "lap") as UIImage?, for: .normal)

        lapBtn.isEnabled = true
        
    }
    
    func timerHasStopped() {
      
        startBtn.setBackgroundImage(UIImage(named: "start") as UIImage?, for: .normal)
        if let _ = watch.timer, (watch.timer?.isValid)! == false {
          
            lapBtn.setBackgroundImage(UIImage(named: "reset") as UIImage?, for: .normal)
            
        }
        else {
            lapBtn.isEnabled = false
        }
    }
    
    func timerWasReset() {
        lapTblV.reloadData()
        initializeTimerUI()
    }

    func initializeTimerUI() {

        timeLbl.text = "00 : 00 : 00"
        
        lapBtn.isEnabled = false
      
        lapBtn.setBackgroundImage(UIImage(named: "lapFade") as UIImage?, for: .normal)
        startBtn.setBackgroundImage(UIImage(named: "start") as UIImage?, for: .normal)
        
        timerHasStopped()
    }

    @IBAction func startAct(_ sender: UIButton) {
    
    if let _ = watch.timer, (watch.timer?.isValid)! {
           
        watch.stopTimer()
    
    } else {
        
        watch.startTimer()
           
     }
 }
    
    @IBAction func lapAct(_ sender: UIButton) {
   
     if let _ = watch.timer, (watch.timer?.isValid)! {
             
        watch.completeLap()
           
     }else {
            watch.resetTimer()
    }
}

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return watch.laps.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var temp: [TimeInterval] = []
               if(watch.timeIntervalss.count>2){
                   temp = watch.timeIntervalss
                   temp.sort()
               }
        
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        
        let reverseIndex = watch.timeIntervalss.count - 1 - (indexPath as NSIndexPath).row
       
        let lap = watch.timeIntervalss[reverseIndex]
        
        cell.backgroundColor = .black
        
        if(temp.count>2){
            if(lap==temp[0]){
                
                cell.detailTextLabel?.textColor = UIColor.green
                cell.textLabel?.textColor = UIColor.green

            }
            else if(lap==temp[temp.count-1]){
               
                cell.detailTextLabel?.textColor = UIColor.red
                cell.textLabel?.textColor = UIColor.red
                
            }else {
                    
                cell.detailTextLabel?.textColor = UIColor.white
                cell.textLabel?.textColor = UIColor.white
                 }
             }else{
                 cell.detailTextLabel?.textColor = UIColor.white
                 cell.textLabel?.textColor = UIColor.white
         }
        
           cell.textLabel?.text = "Lap \(reverseIndex + 1)"
           
           cell.detailTextLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: UIFont.Weight.regular)
           
           cell.detailTextLabel?.text = "\(watch.laps[reverseIndex])"
       
        return cell
    
    }

}
