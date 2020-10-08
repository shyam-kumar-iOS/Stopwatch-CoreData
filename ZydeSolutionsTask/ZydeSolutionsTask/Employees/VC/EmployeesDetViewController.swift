//
//  EmployeesDetViewController.swift
//  ZydeSolutionsTask
//
//  Created by Shyam Kumar on 10/1/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import UIKit

enum mode {
    case view
    case edit
    case add
}

class EmployeesDetViewController: UIViewController {

    @IBOutlet weak var firstTxtF: UITextField!
    
    @IBOutlet weak var lastTxtF: UITextField!
    
    @IBOutlet weak var emailTxtF: UITextField!
    
    @IBOutlet weak var designationTxtF: UITextField!
    
    @IBOutlet weak var phoneTxtF: UITextField!
    
    @IBOutlet weak var actionBtn: UIButton!
   
    
    let dB = DatabaseHelper()
    
    var employees = [Employees]()
    
    var employ : Employees?
    
    var mode : mode!
    
    let arr = ["" ,"iOS Developer", "Android Developer", "Fullstack Developer", "Backend Developer"]
    
    var pickerV = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
        
        pickerV.dataSource = self
        pickerV.delegate = self
 
        configureEdit()
        designationTxtF.inputView = pickerV
     
    }
    
    @IBAction func Action(_ sender: UIButton) {
    
        if sender.title(for: .normal) == "Save" {
       
            configureAndSave()
            
        } else {
            
            configureAndEdit()
        
        }
    
    }
    
    func configureAndSave() {
        
     if validateFields(str: emailTxtF.text!) {
        guard let employee = dB.add(Employees.self) else {return}
            
            if let firstName = firstTxtF.text {
                 employee.firstName = firstName
            }
             
            if let lastName = lastTxtF.text {
                 employee.lastName = lastName
            }
             
            if let email = emailTxtF.text {
                 employee.email = email
            }
                 
            if let phone = phoneTxtF.text {
                 employee.phone = phone
            }
            
            if let designation = designationTxtF.text {
                 employee.designation = designation
            }
                 
              employees.append(employee)
                 
              saveAndNav()
        }
    }
    
    func configureAndEdit() {
           
        if validateFields(str: emailTxtF.text!) {
            
            if let firstName = firstTxtF.text {
                  employ?.setValue(firstName , forKey: "firstName")
             }
                      
             if let lastName = lastTxtF.text {
                  employ?.setValue(lastName , forKey: "lastName")
             }
                      
             if let email = emailTxtF.text {
                  employ?.setValue(email , forKey: "email")
             }
                           
             if let email = emailTxtF.text {
                  employ?.setValue(email , forKey: "email")
             }
                           
             if let phone = phoneTxtF.text {
                  employ?.setValue(phone , forKey: "phone")
             }
              
             if let designation = designationTxtF.text {
                  employ?.setValue(designation , forKey: "designation")
             }
                      
                saveAndNav()
        }
    }
      
    func configureEdit() {
        
    if mode == .edit {

        configData(str: "Edit Employee")

    } else if mode == .view {
          configData(str: "View Employee")
        actionBtn.isHidden = true
        toggle(bool : false)
        
        
    }else {
       
        let customTitle =  self.navigationController?.visibleViewController?.navigationItem
               customTitle?.title = "Add Employee"
        actionBtn.setTitle("Save", for: .normal)
        
    }
  }
    
    func saveAndNav() {
        
        dB.save()
           
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
           
        navigationController?.popViewController(animated: true)
        
    }
    
    func configData(str: String) {
         
        let customTitle =  self.navigationController?.visibleViewController?.navigationItem
          customTitle?.title = str
          
          print("dfvdfv", employ!)
          actionBtn.setTitle("Edit", for: .normal)
                      
          firstTxtF.text  = employ?.firstName

          lastTxtF.text = employ?.lastName
                       
          emailTxtF.text  = employ?.email
          
          phoneTxtF.text  = employ?.phone
                                
          designationTxtF.text  = employ?.designation
    }
    
    func toggle(bool : Bool) {
        
        firstTxtF.isUserInteractionEnabled = bool
        lastTxtF.isUserInteractionEnabled = bool
        emailTxtF.isUserInteractionEnabled = bool
        phoneTxtF.isUserInteractionEnabled = bool
        designationTxtF.isUserInteractionEnabled = bool
        
    }
    
    func validateFields(str: String) -> Bool  {
        
        guard !firstTxtF.text!.isEmpty == true else {
            showToast(message: "First name cannot be empty", font: .systemFont(ofSize: 12.0))
            return false
        }
        
        guard !lastTxtF.text!.isEmpty == true else {
            showToast(message: "Last name cannot be empty", font: .systemFont(ofSize: 12.0))
            return false
        }
        
        guard validateEmail(enteredEmail: str) == true else {
            return false
        }
        
        guard !designationTxtF.text!.isEmpty == true else {
            showToast(message: "Designation cannot be empty", font: .systemFont(ofSize: 12.0))
            return false
        }
        
        guard phoneTxtF.text!.count == 10 else {
            showToast(message: "Phone Number must contain 10 chars", font: .systemFont(ofSize: 12.0))
            return false
        }
        
         return true
    
    }
    
    func validateEmail(enteredEmail:String) -> Bool {

    
        guard !enteredEmail.isEmpty else {
        showToast(message: "Email must not be empty", font: .systemFont(ofSize: 12.0))
            return false
        }

        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        guard emailPredicate.evaluate(with: enteredEmail) else {
            showToast(message: "Please enter a valid EmailId", font: .systemFont(ofSize: 12.0))
            return false
        }

        guard enteredEmail.count != 6 else {
        showToast(message: "Email must contain atleast 6 characters", font: .systemFont(ofSize: 12.0))
            return false
        }
        
        return true

    }
    
}

extension EmployeesDetViewController : UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       
        return 1
    
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return arr.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return arr[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        designationTxtF.text = arr[row]
        
        designationTxtF.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
}
