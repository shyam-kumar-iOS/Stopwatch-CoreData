//
//  EmployeesViewController.swift
//  ZydeSolutionsTask
//
//  Created by Shyam Kumar on 9/30/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

class EmployeesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tblV: UITableView!
    
    let dB = DatabaseHelper()
    
    var employees = [Employees]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        employees = dB.fetch(Employees.self)
        
        tblV.register(EmployeeTblVCell.nib, forCellReuseIdentifier: EmployeeTblVCell.identifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getData(_:)), name: NSNotification.Name("reload"), object: nil)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTblVCell.identifier, for: indexPath) as! EmployeeTblVCell
        
        if employees.count > 0 {
        cell.nameLbl.text = "\(employees[indexPath.row].firstName) \(employees[indexPath.row].lastName)"
        
        cell.designationLabel.text = employees[indexPath.row].designation
            
            ImgPlaceholder.generateImg(str: "\(employees[indexPath.row].firstName)", imgView: cell.imgV, gradientBg: true)
        }
       
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 75
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        showAlertAction(title: "View or Edit", message: "What would you like to do", index: indexPath)
        

        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

      let employee = employees[indexPath.row]
      self.dB.delete(object: employee)
      employees.remove(at: indexPath.row)
      tblV.deleteRows(at: [indexPath], with: .automatic)

    }
    
    @objc func getData(_ notification: NSNotification) {
        
        employees = dB.fetch(Employees.self)
        
        self.tblV.reloadData()
        
    }
    
    @IBAction func addAct(_ sender: UIBarButtonItem) {
   

        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        
            let vc = sb.instantiateViewController(identifier: "EmployeesDetViewController") as! EmployeesDetViewController
            vc.mode = .add
            
        
            navigationController?.pushViewController(vc, animated: true)
       
    
    }
    
    func showAlertAction(title: String, message: String, index : IndexPath){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "View", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            
            self.detailsNav(mode: .view, indexpath: index)
        
        }))
        alert.addAction(UIAlertAction(title: "Edit", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
                
           self.detailsNav(mode: .edit, indexpath: index)
        
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func detailsNav(mode: mode, indexpath: IndexPath) {
        

        
                let sb = UIStoryboard.init(name: "Main", bundle: nil)
                   let vc = sb.instantiateViewController(identifier: "EmployeesDetViewController") as! EmployeesDetViewController
                    vc.employ = self.employees[indexpath.row]
                    vc.mode = mode
                   self.navigationController?.pushViewController(vc, animated: true) 
        
    }
    
    @IBAction func backNav(_ sender: UIBarButtonItem) {
    
        navigationController?.popViewController(animated: true)
        
    }
    
}
