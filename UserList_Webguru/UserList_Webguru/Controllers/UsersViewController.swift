//
//  UsersViewController.swift
//  UserList_Webguru
//
//  Created by Vrushali Mahajan on 5/10/21.
//

import UIKit

class UsersViewController: BaseViewController {

    @IBOutlet weak var usersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsersList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        usersTableView.reloadData()
    }
    
    private func fetchUsersList() {
        displayActivityIndicator(onView: self.view)
        UserServiceManager.shared.getUsersList { [weak self] in
            self?.removeActivityIndicator()
            DispatchQueue.main.async { [weak self] in
                self?.usersTableView.reloadData()
            }
        } onFailure: { [weak self] (errorTitle, message) in
            self?.removeActivityIndicator()
            self?.showAlert(withTitle: errorTitle, message: message)
        }
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserServiceManager.shared.usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = usersTableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as? UserTableViewCell else {
            return UITableViewCell()
        }
        cell.setUpCell(user: UserServiceManager.shared.usersArray[indexPath.row], index: (indexPath.row + 1))
        return cell
    }
}
