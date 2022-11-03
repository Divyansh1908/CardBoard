//
//  loginViewController.swift
//  CardBoard
//
//  Created by Divyansh Singh on 03/11/22.
//

import UIKit
import GoogleSignIn
import GoogleSignInSwift
import Parse

class loginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginPasswordField: UITextField!
    @IBOutlet weak var loginEmailAddress: UITextField!
    
    // LogIn Manually
    @IBAction func loginManuallyButton(_ sender: Any) {
        print("Log In Manually Clicked")
    }
    
    // LogIn with Apple
    @IBAction func loginWithAppleButton(_ sender: Any) {
        print("Log In Apple Clicked")
        Toast.show(message: "Coming Soon!", controller: self)
    }
    
    // LogIn with Google
    @IBAction func loginWithGoogleButton(_ sender: Any) {
        print("Log In Google Clicked")
    }
    
    // Login with Twitter
    @IBAction func loginWithTwitter(_ sender: Any) {
        print("Log In Twitter Clicked")
        Toast.show(message: "Coming Soon!", controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss keyboard after pressing enter button on PasswordField
        loginPasswordField.delegate = self // set delegate
        
        // Tap Anywhere and the keyboard shuts down
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap) // Add gesture recognizer to background view
        
        // Edge Swipe
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
    }
    
    //Edge Swipe - CONT
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped left - back to StartUp screen from LogIn")
            self.performSegue(withIdentifier: "backToOnboardFromLogin", sender: self)
        }
    }
    
    // Tap Anywhere and the keyboard shuts down - CONT
    @objc func handleTap() {
        loginEmailAddress.resignFirstResponder()
        loginPasswordField.resignFirstResponder()
    }
    
    // Dismiss keyboard after pressing enter button on PasswordField - CONT
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
