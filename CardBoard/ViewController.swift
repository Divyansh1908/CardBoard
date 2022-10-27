//
//  ViewController.swift
//  CardBoard
//
//  Created by Divyansh Singh on 25/10/22.
//

import UIKit
import GoogleSignIn
import GoogleSignInSwift

class ViewController: UIViewController {

    let signInConfig = GIDConfiguration(clientID: "154066948810-fbhgjggb582mgppdngc1hsfqvrs22u7i.apps.googleusercontent.com")
    a
    
//    GoogleSignInButton(action: )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func googleButton(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(
            with: signInConfig,
            presenting: self) { user, error in
              guard error == nil else { return }
                guard let user = user else { return }
                   let emailAddress = user.profile?.email
                   let fullName = user.profile?.name
                   let givenName = user.profile?.givenName
                   let familyName = user.profile?.familyName
                print(emailAddress)
                print(fullName)
                print(givenName)
                print(familyName)
              // If sign in succeeded, display the app's main content View.
            }
        
    }
    
}

