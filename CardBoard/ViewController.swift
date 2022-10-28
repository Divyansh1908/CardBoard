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
class ViewController: UIViewController{

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // Signup With Google and push all the data to parse.
    let signInConfig = GIDConfiguration(clientID: "154066948810-fbhgjggb582mgppdngc1hsfqvrs22u7i.apps.googleusercontent.com")
    @IBAction func googleButton(_ sender: Any) {
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
                    print("Please Try Agian")
                } else {
                   print("You have signed up!!")
                }
              }
          // If sign in succeeded, display the app's main content View.
        }
    }
    
    // User SignUp Button when user fills out all the fields and pushes the data to parse.
    @IBAction func signUpButton(_ sender: Any)
    {
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
            print("Please Try Agian")
        } else {
           print("You have signed up!!")
        }
      }
    }
    
//    Twitter Signup Button
    @IBAction func twitterSignInButton(_ sender: Any) {
        print("hello")
        let myUrl = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: myUrl, success: {
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
        }, failure: { (Error) in
            print("Could not Login!")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

