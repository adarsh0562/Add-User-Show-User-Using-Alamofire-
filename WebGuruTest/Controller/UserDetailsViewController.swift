//
//  UserDetailsViewController.swift
//  WebGuruTest
//
//  Created by Adarsh Raj on 30/06/21.
//

import UIKit

class UserDetailsViewController: UIViewController {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var detailsView: UIView!
    var arraylist :[String:Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        detailsView.dropShadow()
    }
    
    func fetchData()
    {
        idLabel!.text! = arraylist["id"] as! String
        nameLabel!.text! = arraylist["name"] as! String
        emailLabel!.text! = arraylist["email"] as! String
        mobileLabel!.text! = arraylist["mobile"] as! String
    }

    
}
//MARK: - IBAction
extension UserDetailsViewController
{
    @IBAction func actionBackBtn(_ sender:Any)
    {
        navigationController?.popViewController(animated: true)
    }
}
