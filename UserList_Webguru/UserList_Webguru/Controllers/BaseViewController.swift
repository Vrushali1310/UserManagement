//
//  ViewController.swift
//  UserList_Webguru
//
//  Created by Vrushali Mahajan on 5/10/21.
//

import UIKit

class BaseViewController: UIViewController {

    var loaderView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(withTitle title : String = "UserList", message : String?) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    func displayActivityIndicator(onView : UIView) {
        let containerView = UIView.init(frame: onView.bounds)
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = containerView.center
        DispatchQueue.main.async {
            containerView.addSubview(activityIndicator)
            onView.addSubview(containerView)
        }
        loaderView = containerView
    }
    
    func removeActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.loaderView?.removeFromSuperview()
            self?.loaderView = nil
        }
    }
}

