//
//  ViewController.swift
//  BioAuthExample
//
//  Created by Sean Murphy on 5/23/22.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let button = UIButton(frame: (CGRect(x: 0, y: 0, width: 200, height: 50)))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Authorize", for: .normal)
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc func didTapButton() {
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authorize with Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                guard success, error == nil else {
                    // failed
                    
                    let alert = UIAlertController(title: "Failed to Authenticate", message: "Please try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self?.present(alert, animated: true)
                    
                    return
                }
                // Show other screen
                // success
                DispatchQueue.main.async {
                let vc = UIViewController()
                vc.title = "Welcome"
                vc.view.backgroundColor = .systemBlue
                self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
                }
            }
        } else {
            // cannot use
            let alert = UIAlertController(title: "Unabailable", message: "You can't use this feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }

}

