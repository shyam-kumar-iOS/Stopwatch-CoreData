//
//  ViewController.swift
//  ZydeSolutionsTask
//
//  Created by Shyam Kumar on 9/30/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.isHidden = true
    
    }

    @IBAction func navStopWatch(_ sender: UIButton) {
    

        let sb = UIStoryboard.init(name: "Main", bundle: nil)

        let vc = sb.instantiateViewController(identifier: "StopWatchViewController") as! StopWatchViewController
       
        navigationController?.pushViewController(vc, animated: true)
    
    }
    
    @IBAction func navEmployees(_ sender: UIButton) {
    
        let sb = UIStoryboard.init(name: "Main", bundle: nil)

        let vc = sb.instantiateViewController(identifier: "EmployeesViewController") as! EmployeesViewController

        navigationController?.pushViewController(vc, animated: true) 
            
    }
}

