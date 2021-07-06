//
//  AddUserViewController.swift
//  WebGuruTest
//
//  Created by Adarsh Raj on 30/06/21.
//

import UIKit
import Alamofire
class AddUserViewController: UIViewController {
 
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var mobileTextFiled: UITextField!
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formView.dropShadow()
        saveBtn.layer.cornerRadius = 10
        
    }
    
    //MARK: - Alert
    func showError(title:String,message: String){
        let alertView = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let btn = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
            alertView.addAction(btn)
         present(alertView, animated: true, completion: nil)
    }
    //MARK:- Action on Alert
      func showAlert(title: String, message: String) -> Void {
         
         let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
         let OKAction = UIAlertAction(title:"Ok", style: .default) {
             (action: UIAlertAction) in
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "UserListTableViewController") as! UserListTableViewController
            self.navigationController?.pushViewController(controller, animated: true)
         }
         alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
     }
    //MARK:-Validation
    func validation()
    {
        let email = validateEmailID(emailID: emailTextFiled!.text!)
        let mobile = validateNumber(mobileTextFiled.text!)
        
        if nameTextFiled.text! == ""{
            showError(title: "Warning", message: "Name is Required")
        }
       else if emailTextFiled.text! == ""{
            showError(title: "Warning", message: "email is Required")
        }
       else if email == false{
            showError(title: "Warning", message: "Invalid Email")
        }
       else if mobileTextFiled.text! == ""{
            showError(title: "Warning", message: "Mobile is Required")
        }
       else if mobile == false{
            showError(title: "Warning", message: "Invalid Mobile")
        }
        else if mobileTextFiled.text?.count != 10{
            showError(title: "Warning", message: "Mobile is Invalid")
        }else{
            addUser()
        }
    }
}


extension AddUserViewController
{
    @IBAction func actionSaveBtn(_ sender: UIButton)
    {
        validation()
    }
    @IBAction func actionBackBtn(_ sender:Any)
    {
        navigationController?.popViewController(animated: true)
    }
}
//MARK:- API Calling
extension AddUserViewController
{
    func addUser()
    {
        ProgressHud.show()
        let parameters = ["name": nameTextFiled!.text!, "email": emailTextFiled!.text!,"mobile":mobileTextFiled!.text!]
        
        AF.request("https://5ec4c2c0628c160016e71369.mockapi.io/users", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { [self] (response) in
           
            switch response.result {
            
            case .success(_):
                ProgressHud.hide()
                if let json = response.value as? [String : Any]
                {
                    let result = json["result"] as! String
                    if result == "success"
                    {
                        showAlert(title: "Success", message: "User added successfully..")
                       
                    }else{
                        
                        showError(title: "Error", message: "Something went wrong..")
                    }
                    
                }
                break
            case .failure(let error):
                ProgressHud.hide()
                showError(title: "Error", message: error.localizedDescription)
                break
            }
        }
    }
}

//MARK:- Validations on text field
extension AddUserViewController
{
    func validateEmailID(emailID:String) -> Bool {
        
        let emailString = emailID.replacingOccurrences(of: " ", with: "")
        if emailString.count == emailID.count {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: emailID)
        }else
        {
            return false
        }
    }
    
      func validateNumber(_ number: String) -> Bool {
        let usernameRegEx = "^[0-9]+$"
        let usernameValidator = NSPredicate(format: "SELF MATCHES %@", usernameRegEx)
        return usernameValidator.evaluate(with: number)
    }
}
