//
//  StopWatch.swift
//  ZydeSolutionsTask
//
//  Created by Shyam Kumar on 10/2/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import Foundation


protocol StopwatchDelegate: class {
    func currentTimerUpdated(seconds: String, minutes: String, milliseconds: String)
    func timerHasStarted()
    func timerHasStopped()
    func timerWasReset()
}

class Stopwatch {
    
    weak var delegate: StopwatchDelegate?
    
    private(set) var timer: Timer?
    
    private(set) var timerStartTime: TimeInterval = 0
    
    private(set) var timerSavedTime: TimeInterval = 0
    
    private(set) var laps = [String]()
    
    private(set) var timeIntervalss = [TimeInterval]()
    
    private(set) var currentLap = 0
    
    private(set) var lapStartTime: TimeInterval?
    
    private(set) var lapSavedTime: TimeInterval = 0
    
  
    
    init(delegate: StopwatchDelegate) {
        self.delegate = delegate
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self,
                                     selector: #selector(timerHasTicked(timer:)),
                                     userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
        
        if laps.count == 0 {
            laps.append("")
            timeIntervalss.append(TimeInterval())
        }
        
        timerStartTime = Date.timeIntervalSinceReferenceDate
        lapStartTime = timerStartTime
        
        delegate?.timerHasStarted()
    }
    
    func stopTimer() {
        
        let currentTime = Date.timeIntervalSinceReferenceDate
        timerSavedTime += currentTime - timerStartTime
        lapSavedTime   += currentTime - lapStartTime!
        
        timer?.invalidate()
        delegate?.timerHasStopped()
    }
    
    func resetTimer() {
        timerSavedTime = 0
        currentLap = 0
        lapSavedTime = 0
        lapStartTime = nil
        laps.removeAll()
        timeIntervalss.removeAll()
        delegate?.timerWasReset()
    }
    
    func completeLap() {
        laps.append("")
        timeIntervalss.append(TimeInterval())
        currentLap += 1
        
        lapStartTime = Date.timeIntervalSinceReferenceDate
        lapSavedTime = 0
    }
    
    @objc private func timerHasTicked(timer: Timer) {
        
        let currentTime = Date.timeIntervalSinceReferenceDate
        let timerElapsedTime: TimeInterval = (currentTime - timerStartTime) + timerSavedTime
        let lapElapsedTime: TimeInterval = (currentTime - lapStartTime!) + lapSavedTime
        
        let minutes = Int(timerElapsedTime / 60.0)
        let seconds = Int(timerElapsedTime - (TimeInterval(minutes) * 60))
        let milliseconds = Int(timerElapsedTime * 100) % 100
           
        
        let lapMinutes = Int(lapElapsedTime / 60.0)
        let lapSeconds = Int(lapElapsedTime - (TimeInterval(lapMinutes) * 60))
        let lapMilliseconds = Int(lapElapsedTime * 100) % 100
            
        
        timeIntervalss[currentLap] = lapElapsedTime
        laps[currentLap] = "\(String(format: "%02u", lapMinutes)):\(String(format: "%02u", lapSeconds)).\(String(format: "%02u", lapMilliseconds))"
        
        
        delegate?.currentTimerUpdated(seconds: String(format: "%02u", seconds),
                                      minutes: String(format: "%02u", minutes),
                                      milliseconds: String(format: "%02u", milliseconds))
    }
}
