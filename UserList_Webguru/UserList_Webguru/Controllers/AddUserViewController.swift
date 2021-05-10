//
//  AddUserViewController.swift
//  UserList_Webguru
//
//  Created by Vrushali Mahajan on 5/10/21.
//

import UIKit

class AddUserViewController: BaseViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var addUserButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUserButton.layer.cornerRadius = addUserButton.frame.size.height / 2
    }

    @IBAction func addUserButtonClicked(_ sender: UIButton) {
                
        guard let userName = nameTextField.text, userName.count > 0 else {
            showAlert(withTitle: "Please enter name to add user.", message: nil)
            return
        }
        
        guard let email = emailTextField.text, Helper.isValidEmail(email) else {
            showAlert(withTitle: "Please enter valid email to add user.", message: nil)
            return
        }
        
        guard let mobile = mobileTextField.text, Helper.isValidPhone(mobile) else {
            showAlert(withTitle: "Please enter valid mobile number to add user.", message: nil)
            return
        }
        
        view.endEditing(true)
        
        let userDict = [
            "name": userName,
            "email": email,
            "mobile": mobile
        ]
        
        displayActivityIndicator(onView: self.view)
        
        UserServiceManager.shared.addUser(userDict: userDict) { [weak self] in
            self?.removeActivityIndicator()
            DispatchQueue.main.async { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        } onFailure: { [weak self] (errorTitle, message) in
            self?.removeActivityIndicator()
            self?.showAlert(withTitle: errorTitle, message: message)
        }
    }
}
