//
//  ViewController.swift
//  CardBoard
//
//  Created by Divyansh Singh on 25/10/22.
//

import UIKit
import GoogleSignIn
import GoogleSignInSwift
import Parse
class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // Signup With Google and push all the data to parse.
    let signInConfig = GIDConfiguration(clientID: "154066948810-fbhgjggb582mgppdngc1hsfqvrs22u7i.apps.googleusercontent.com")
    @IBAction func googleButton(_ sender: Any)
    {
        print("Clicked Google SignUp Button")
        let users = PFUser()
        var emailAddress: String?
        var firstName: String?
        var lastName: String?
        var fullName: String?
        GIDSignIn.sharedInstance.signIn( with: signInConfig, presenting: self)
        {
        user, error in
        guard error == nil else { return }
        guard let user = user else { return }
        emailAddress = user.profile?.email
        fullName = user.profile?.name
        firstName = user.profile?.givenName
        lastName = user.profile?.familyName
            print(emailAddress ?? "none")
            print(fullName ?? "none")
            print(firstName ?? "none") 
            print(lastName ?? "none")
            users["FirstName"] = firstName ?? "none"
            users["LastName"] = lastName ?? "none"
            users.email = emailAddress ?? "none@none.com"
            users.username = emailAddress ?? "none@none.com"
            users.password = "none"
            users.signUpInBackground {
                (succeeded: Bool, error: Error?) -> Void in
                if let error = error {
                  let errorString = error.localizedDescription
                  // Show the errorString somewhere and let the user try again.
                    print("Google - Please Try Agian!")
                } else {
                   print("User SignedUp using Google!!")
                }
              }
          // If sign in succeeded, display the app's main content View.
        }
    }
    
    //User SignUp Button when user fills out all the fields and pushes the data to parse. - Manual
    @IBAction func signUpButton(_ sender: Any)
    {
    print("Clicked Manual SignUp Button")
    let users = PFUser()
    users["FirstName"] = firstNameField.text
    users["LastName"] = lastNameField.text
    users.email = emailAddressField.text
    users.password = passwordField.text
    users.username = emailAddressField.text
    users.signUpInBackground {
        (succeeded: Bool, error: Error?) -> Void in
        if let error = error {
          let errorString = error.localizedDescription
          // Show the errorString somewhere and let the user try again.
            print("Manual - Please Try Agian")
        } else {
           print("User SignedUp Manually!")
        }
      }
    }
    
    //Twitter SignUp Button
    @IBAction func twitterSignInButton(_ sender: Any)
    {
        print("Clicked Twitter SignUp Button")
        Toast.show(message: "Coming Soon!", controller: self)
//        let myUrl = "https://api.twitter.com/oauth/request_token"
//        TwitterAPICaller.client?.login(url: myUrl, success: {
//            self.performSegue(withIdentifier: "loginToHome", sender: self)
//            print("LoggedIn")
//        }, failure: { (Error) in
//            print("Could not Login!")
//            Toast.show(message: "Coming Soon!", controller: self)
//        })
    }
    
    //Apple SignUp Button
    @IBAction func appleSignInButton(_ sender: Any) {
        print("Clicked Apple SignUp Button")
        Toast.show(message: "Coming Soon!", controller: self)
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss keyboard after pressing enter button on PasswordField
        passwordField.delegate = self // set delegate
        
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
            print("Screen edge swiped left - back to StartUp screen from - SignUp")
            self.performSegue(withIdentifier: "goBackToOnboard", sender: self)
        }
    }
    // Tap Anywhere and the keyboard shuts down - CONT
    @objc func handleTap() {
        passwordField.resignFirstResponder() // dismiss keyoard
        emailAddressField.resignFirstResponder()
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
    }
    
    // Dismiss keyboard after pressing enter button on PasswordField - CONT
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }

}

