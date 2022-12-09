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
import SwiftUI

class loginViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var loginPasswordField: UITextField!
    @IBOutlet weak var loginEmailAddress: UITextField!
    
    // LogIn Manually
    @IBAction func loginManuallyButton(_ sender: Any) {
        print("Log In Manually Clicked")
        let username = loginEmailAddress.text!
        let password = loginPasswordField.text!
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil
            {
                // Home Screen coming soon
                self.performSegue(withIdentifier: "signInToHome", sender: nil)
                print("Manual Login Successful")
            }
            else
            {
                Toast.show(message: "Invalid UserName/Password", controller: self)
                print("Error: \(error?.localizedDescription) in Manual Login")
            }
        }
    }
    
    // LogIn with Apple
    @IBAction func loginWithAppleButton(_ sender: Any) {
        print("Log In Apple Clicked")
        Toast.show(message: "Coming Soon!", controller: self)
    }
    
    // LogIn with Google
    @IBAction func loginWithGoogleButton(_ sender: Any) {
        print("Log In Google Clicked")
        let signInConfig = GIDConfiguration(clientID: "154066948810-fbhgjggb582mgppdngc1hsfqvrs22u7i.apps.googleusercontent.com")
        let users = PFUser()
        var username: String?
        GIDSignIn.sharedInstance.signIn( with: signInConfig, presenting: self)
            {
            user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            username = user.profile?.email
            print(username ?? "none")
            PFUser.logInWithUsername(inBackground: (username ?? "none"), password: "none") { (user, error) in
                if user != nil
                {
                    // Home Screen Coming soon
                    self.performSegue(withIdentifier: "signInToHome", sender: nil)
                    print("Google Login Successful")
                }
                else
                {
                    Toast.show(message: "Invalid UserName/Password", controller: self)
                    print("Error: \(error?.localizedDescription) in Google Login")
                }
            }
        }
        
        
        //To check if the user already has a signedin account session running
//        if(GIDSignIn.sharedInstance.hasPreviousSignIn() == false)
//        {
//            Toast.show(message: "Please SignUp using Google", controller: self)
//        }
//        else
//        {
//            self.performSegue(withIdentifier: "loginToAddCards", sender: nil)
//            print("Google Login Successful")
//        }
//        if()
//        {
//            print("Already hai")
//        }
    }
    
    // Login with Twitter
    @IBAction func loginWithTwitter(_ sender: Any) {
        print("Log In Twitter Clicked")
        Toast.show(message: "Coming Soon!", controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance.restorePreviousSignIn()
        
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
