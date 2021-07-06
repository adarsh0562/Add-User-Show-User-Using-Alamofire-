//
//  UserListTableViewController.swift
//  WebGuruTest
//
//  Created by Adarsh Raj on 30/06/21.
//

import UIKit
import Alamofire
class UserListTableViewController: UITableViewController {
    @IBOutlet weak var listTableView: UITableView!
    
    var userListArray: [[String:Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserDetails()
        
    }
    func showError(title:String,message: String){
        let alertView = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
      
        let btn = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
            alertView.addAction(btn)
         present(alertView, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userListArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell", for: indexPath) as! UserListTableViewCell
        let cellData = userListArray[indexPath.row]
        cell.nameLabel!.text! = "Name : - \(cellData["name"] as! String)"
        cell.emailLabel!.text! = "Email : - \(cellData["email"] as! String)"
        cell.mobileLabel!.text! = "Mobile : - \(cellData["mobile"] as! String)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = userListArray[indexPath.row]
        let nextController = storyboard?.instantiateViewController(identifier: "UserDetailsViewController") as! UserDetailsViewController
        nextController.arraylist = data
        self.navigationController?.pushViewController(nextController, animated: true)
    }
  
}
//MARK:- IBAction
extension UserListTableViewController
{
    @IBAction func addUserBtn(_ sender:Any)
    {
        let nextControllwer = storyboard?.instantiateViewController(identifier: "AddUserViewController") as! AddUserViewController
        self.navigationController?.pushViewController(nextControllwer, animated: true)
    }
}
//MARK:- Api Calling
extension UserListTableViewController
{
    func getUserDetails()
    {
        ProgressHud.show()
        AF.request("https://5ec4c2c0628c160016e71369.mockapi.io/users", method: .get, encoding: JSONEncoding.default).responseJSON { [self] response in
                
                switch response.result  {
                
                case .success(_):
                    ProgressHud.hide()
                    if let json = response.value as? [[String : Any]]
                    {
                                                
                        for userList in json
                        {
                            let id = userList["id"] as! String
                            let name = userList["name"] as! String
                            let email = userList["email"] as! String
                            let mobile = userList["mobile"] as! String
                            let dic = ["id":id,"name":name,"email":email,"mobile":mobile]
                            
                            userListArray.append(dic)
                        }
                        
                        DispatchQueue.main.async
                        {
                            listTableView.reloadData()
                            
                        }
                    }
                case .failure(let error):
                    ProgressHud.hide()
                    showError(title: "Error", message: error.localizedDescription)
                }
            }
    }
}

