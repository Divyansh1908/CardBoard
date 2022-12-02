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
    var check: Bool = false
    
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
                   self.performSegue(withIdentifier: "signUpToAddCards", sender: nil)
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
           self.performSegue(withIdentifier: "signUpToAddCards", sender: nil)
            
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
        
//      LOGOUT TEST BUTTON
        GIDSignIn.sharedInstance.signOut()
        PFUser.logOut()
        
        // Refer Google SignIN
        // User Deletion
//        let query = PFQuery(className: "User")
//        var objectId: String?
//        objectId = PFUser.current()?.objectId ?? "none"
//        print(objectId)
//        query.getObjectInBackground(withId: objectId!)
//        { (object, error) -> Void in
//            if object != nil && error == nil {
//                object!.deleteInBackground()
//        }
//        }
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
        
        if(check == false)
        {
            print("Database Already Updated")
        }
        else
        {
            addingCardDetails()
        }
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
    
    func addingCardDetails()
    {
        //APPLE CARD
        var AllCardInfoTable = PFObject (className: "AllCardInfoTable")
        AllCardInfoTable["BankName"] = "Goldman Sachs"
        AllCardInfoTable["CardName"] = "Apple Card"
        AllCardInfoTable["Title1"] = "Get 3% Daily Cash back on anything you buy from Apple"
        AllCardInfoTable["Title2"] = "Get 3% Daily Cash back at select merchants like Nike, Uber, Walgreens, and more when you use Apple Card with Apple Pay"
        AllCardInfoTable["Title3"] = "Get 2% Daily Cash back every time you pay with your iPhone or Apple Watch"
        AllCardInfoTable["Title4"] = "Get 1% Daily Cash back on all other purchases"
        AllCardInfoTable["RewardCategory"] = "Cashback"
        AllCardInfoTable["Dining"] = 2
        AllCardInfoTable["Gas"] = 2
        AllCardInfoTable["ECommerce"] = 2
        AllCardInfoTable["Groceries"] = 2
        AllCardInfoTable["Supermarket"] = 2
        AllCardInfoTable["Streaming"] = 2
        AllCardInfoTable["Travel"] = 1
        AllCardInfoTable["Entertainment"] = 1
        AllCardInfoTable["Lifestyle"] = 1
        AllCardInfoTable["Others"] = 1
        let image:UIImage? = UIImage (named: "appleCard")
        if let smileimage = image
        {
            let imagedata:NSData? = smileimage.pngData () as NSData?
            let file = PFFileObject(name: "appleCard.png", data: imagedata! as Data)
            AllCardInfoTable["image"] = file
        }
        
        // Amex Platinum
        AllCardInfoTable["BankName"] = "American Express"
        AllCardInfoTable["CardName"] = "Amex Platinum Card"
        AllCardInfoTable["Title1"] = "Earn 80,000 Membership Rewards® points after you spend $6,000 on purchases on your new Card in your first 6 months of Card Membership"
        AllCardInfoTable["Title2"] = "Earn 5X Membership Rewards® Points for flights booked directly with airlines or with American Express Travel"
        AllCardInfoTable["Title3"] = "Earn 5X Membership Rewards® Points on prepaid hotels booked with American Express Travel"
        AllCardInfoTable["Title4"] = "Earn 1X Membership Rewards® Points on all projects"
        AllCardInfoTable["RewardCategory"] = "Points"
        AllCardInfoTable["Dining"] = 1
        AllCardInfoTable["Gas"] = 1
        AllCardInfoTable["ECommerce"] = 1
        AllCardInfoTable["Groceries"] = 1
        AllCardInfoTable["Supermarket"] = 1
        AllCardInfoTable["Streaming"] = 1
        AllCardInfoTable["Travel"] = 1
        AllCardInfoTable["Entertainment"] = 1
        AllCardInfoTable["Lifestyle"] = 1
        AllCardInfoTable["Others"] = 1
        let image2:UIImage? = UIImage (named: "amexPlatinum")
        if let smileimage = image2
        {
            let imagedata:NSData? = smileimage.pngData () as NSData?
            let file = PFFileObject(name: "amexPlatinum.png", data: imagedata! as Data)
            AllCardInfoTable["image"] = file
        }
        
        //Discover It Chrome Cashback
        AllCardInfoTable["BankName"] = "Discover"
        AllCardInfoTable["CardName"] = "Discover It Chrome Cashback"
        AllCardInfoTable["Title1"] = "Earn 2% cash back at Gas Stations and Restaurants on up to $1,000 in combined purchases each quarter"
        AllCardInfoTable["Title2"] = "Earn unlimited 1% cash back on all other purchases – automatically"
        AllCardInfoTable["Title3"] = ""
        AllCardInfoTable["Title4"] = ""
        AllCardInfoTable["RewardCategory"] = "Cashback"
        AllCardInfoTable["Dining"] = 2
        AllCardInfoTable["Gas"] = 2
        AllCardInfoTable["ECommerce"] = 1
        AllCardInfoTable["Groceries"] = 1
        AllCardInfoTable["Supermarket"] = 1
        AllCardInfoTable["Streaming"] = 1
        AllCardInfoTable["Travel"] = 1
        AllCardInfoTable["Entertainment"] = 1
        AllCardInfoTable["Lifestyle"] = 1
        AllCardInfoTable["Others"] = 1
        let image3:UIImage? = UIImage (named: "discoverCashback")
        if let smileimage = image3
        {
            let imagedata:NSData? = smileimage.pngData () as NSData?
            let file = PFFileObject(name: "discoverCashback.png", data: imagedata! as Data)
            AllCardInfoTable["image"] = file
        }

        //Chase Sapphire Preferred Card
        AllCardInfoTable["BankName"] = "Chase Bank"
        AllCardInfoTable["CardName"] = "Chase Sapphire Preferred Card"
        AllCardInfoTable["Title1"] = "Earn 60,000 bonus points after you spend $4,000 on purchases in the first 3 months from account opening. That's $750 when you redeem through Chase Ultimate Rewards"
        AllCardInfoTable["Title2"] = "Earn 5x on travel purchased through Chase Ultimate Rewards & 2x on all other travel purchases"
        AllCardInfoTable["Title3"] = "Earn 3x on dining & restaurants"
        AllCardInfoTable["Title4"] = "Earn 1x on all other purchases"
        AllCardInfoTable["RewardCategory"] = "Points"
        AllCardInfoTable["Dining"] = 3
        AllCardInfoTable["Gas"] = 1
        AllCardInfoTable["ECommerce"] = 1
        AllCardInfoTable["Groceries"] = 3
        AllCardInfoTable["Supermarket"] = 1
        AllCardInfoTable["Streaming"] = 3
        AllCardInfoTable["Travel"] = 2
        AllCardInfoTable["Entertainment"] = 1
        AllCardInfoTable["Lifestyle"] = 1
        AllCardInfoTable["Others"] = 1
        let image4:UIImage? = UIImage (named: "chaseSapphire")
        if let smileimage = image4
        {
            let imagedata:NSData? = smileimage.pngData () as NSData?
            let file = PFFileObject(name: "chaseSapphire.png", data: imagedata! as Data)
            AllCardInfoTable["image"] = file
        }
//
        //Capital One Venture X
        AllCardInfoTable["BankName"] = "Capital One"
        AllCardInfoTable["CardName"] = "Capital One Venture X"
        AllCardInfoTable["Title1"] = "Earn 75,000 bonus miles when you spend $4,000 on purchases in the first 3 months from account opening, equal to $750 in travel"
        AllCardInfoTable["Title2"] = "Get 10,000 bonus miles (equal to $100 towards travel) every year, starting on your first anniversary"
        AllCardInfoTable["Title3"] = "Earn unlimited 10X miles on hotels and rental cars booked through Capital One Travel and 5X miles on flights booked through Capital One Travel"
        AllCardInfoTable["Title4"] = "Earn unlimited 2X miles on all other purchases"
        AllCardInfoTable["RewardCategory"] = "Points"
        AllCardInfoTable["Dining"] = 2
        AllCardInfoTable["Gas"] = 2
        AllCardInfoTable["ECommerce"] = 2
        AllCardInfoTable["Groceries"] = 2
        AllCardInfoTable["Supermarket"] = 2
        AllCardInfoTable["Streaming"] = 2
        AllCardInfoTable["Travel"] = 2
        AllCardInfoTable["Entertainment"] = 2
        AllCardInfoTable["Lifestyle"] = 2
        AllCardInfoTable["Others"] = 2
        let image5:UIImage? = UIImage (named: "capitalOneVentureX")
        if let smileimage = image5
        {
            let imagedata:NSData? = smileimage.pngData () as NSData?
            let file = PFFileObject(name: "capitalOneVentureX.png", data: imagedata! as Data)
            AllCardInfoTable["image"] = file
        }
//
        //American Express Delta Skymiles Platinum Card
        AllCardInfoTable["BankName"] = "American Express"
        AllCardInfoTable["CardName"] = "Amex Delta Skymiles Platinum Card"
        AllCardInfoTable["Title1"] = "Earn 80,000 bonus miles after you spend $4,000 in purchases on your new Card in your first 6 months"
        AllCardInfoTable["Title2"] = "Earn 3X Miles on Delta purchases and purchases made directly with hotels"
        AllCardInfoTable["Title3"] = "Earn 2X Miles at restaurants worldwide including takeout and delivery in the U.S., and at U.S. supermarkets"
        AllCardInfoTable["Title4"] = "Earn 1X Miles on all other eligible purchases"
        AllCardInfoTable["RewardCategory"] = "Miles"
        AllCardInfoTable["Dining"] = 2
        AllCardInfoTable["Gas"] = 1
        AllCardInfoTable["ECommerce"] = 1
        AllCardInfoTable["Groceries"] = 1
        AllCardInfoTable["Supermarket"] = 2
        AllCardInfoTable["Streaming"] = 1
        AllCardInfoTable["Travel"] = 3
        AllCardInfoTable["Entertainment"] = 1
        AllCardInfoTable["Lifestyle"] = 1
        AllCardInfoTable["Others"] = 1
        let image6:UIImage? = UIImage (named: "amexDeltaPlatinum")
        if let smileimage = image6
        {
            let imagedata:NSData? = smileimage.pngData () as NSData?
            let file = PFFileObject(name: "amexDeltaPlatinum.png", data: imagedata! as Data)
            AllCardInfoTable["image"] = file
        }
//
        //Wells Fargo Active Cash Card
        AllCardInfoTable["BankName"] = "Wells Fargo"
        AllCardInfoTable["CardName"] = "Wells Fargo Active Cash Card"
        AllCardInfoTable["Title1"] = "Earn a $200 cash rewards bonus after spending $1,000 in purchases in the first 3 months"
        AllCardInfoTable["Title2"] = "Earn unlimited 2% cash rewards on purchases"
        AllCardInfoTable["Title3"] = ""
        AllCardInfoTable["Title4"] = ""
        AllCardInfoTable["RewardCategory"] = "Cashback"
        AllCardInfoTable["Dining"] = 2
        AllCardInfoTable["Gas"] = 2
        AllCardInfoTable["ECommerce"] = 2
        AllCardInfoTable["Groceries"] = 2
        AllCardInfoTable["Supermarket"] = 2
        AllCardInfoTable["Streaming"] = 2
        AllCardInfoTable["Travel"] = 2
        AllCardInfoTable["Entertainment"] = 2
        AllCardInfoTable["Lifestyle"] = 2
        AllCardInfoTable["Others"] = 2
        let image7:UIImage? = UIImage (named: "wellsFargoActiveCash")
        if let smileimage = image7
        {
            let imagedata:NSData? = smileimage.pngData () as NSData?
            let file = PFFileObject(name: "wellsFargoActiveCash.png", data: imagedata! as Data)
            AllCardInfoTable["image"] = file
        }
        
        
        AllCardInfoTable.saveInBackground
        {
            (success, error) -> Void in
            if success{
                print("Saved To database")
            }
            else
            {
                print(error)
            }
        }
    }
    
    

}

