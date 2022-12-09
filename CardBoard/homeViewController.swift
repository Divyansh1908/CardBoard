//
//  homeViewController.swift
//  CardBoard
//
//  Created by Divyansh Singh on 06/12/22.
//

import UIKit
import Foundation
import Parse
import Alamofire
import AlamofireImage
import OrderedCollections
import GoogleSignIn
import GoogleSignInSwift

class homeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{

    

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    @IBOutlet weak var emailOfUser: UILabel!
    @IBOutlet var categoryPicker: UIPickerView!
    var rowSelected: String = ""
    var price: Float = 0.0
    @IBOutlet weak var priceGetter: UITextField!
    
    var cashbackDict: OrderedDictionary<String, Int> = [:]
    var pointsDict: OrderedDictionary<String, Int> = [:]
    var milesDict: OrderedDictionary<String, Int> = [:]
    
    var calculatedCashBack: OrderedDictionary<String, Float> = [:]
    var calculatedPoints: OrderedDictionary<String, Float> = [:]
    var calculatedMiles: OrderedDictionary<String, Float> = [:]
    
    var objects: [PFObject]?
    var huiiii: [PFObject]?
    
    var cashBackrewardCato = [String]()
    var pointsrewardCato = [String]()
    var milesrewardCato = [String]()
    var finalsrewardCato = [String]()
    
    var cashBackurlStringForImage = [String]()
    var pointsurlStringForImage = [String]()
    var milesStringForImage = [String]()
    var finalsStringForImage = [String]()
    
    var photosStringForImage = [String]()
    struct finalwa {
       static var finals: OrderedDictionary<String, Float> = [:]
    }
    let data = ["Gas", "Dining", "ECommerce", "Groceries", "Supermarket", "Streaming", "Travel", "Entertainment", "Lifestyle", "Others"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
        //Dismiss KeyBoard
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap) // Add gesture recognizer to background view
        
        priceGetter.delegate = self
        emailOfUser.text = PFUser.current()!.email as! String
        
        //users()
        //cardPhoto()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.cardPhoto()
        DispatchQueue.main.asyncAfter(deadline:.now() + 2.5, execute: {
            print(self.photosStringForImage.count)
            if(self.photosStringForImage.count>=1){
                let urlo = URL(string: self.photosStringForImage[0])!
                self.image4.af.setImage(withURL: urlo)
            }
            if(self.photosStringForImage.count>=2){
                let urlo = URL(string: self.photosStringForImage[1])!
                self.image3.af.setImage(withURL: urlo)
            }
            if(self.photosStringForImage.count>=3){
                let urlo = URL(string: self.photosStringForImage[2])!
                self.image2.af.setImage(withURL: urlo)
            }
            if(self.photosStringForImage.count>=4){
                let urlo = URL(string: self.photosStringForImage[3])!
                self.image1.af.setImage(withURL: urlo)
            }
            
        })
        
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       rowSelected = data[row]
        //print(type(of: data[row]))
    }
    //Dismiss the keyboard
    @objc func handleTap() {
        priceGetter.resignFirstResponder() // dismiss keyoard
    }
    //Dismiss the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
    
    
//    //Do later
//    func users()
//    {
//        var xyz = PFUser.current()!.objectId as! String
//        let query1 = PFQuery(className:"User")
//        query1.includeKey("FirstName")
//        query1.whereKey("objectId", contains: xyz)
//        query1.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
//            if let error = error {
//                // Log details of the failure
//                print(error.localizedDescription)
//            } else if let objects = objects {
//                // The find succeeded.
//                print("Successfully retrieved \(objects.count) photos")
//                // Do something with the found objects
//                for object in objects {
////                    if(object.objectId as! String == xyz)
////                    {
//                        print(object["FirstName"] as! String)
////                    }
//
//                }
//            }
//        }
//    }
    
    
    func cardPhoto()
    {
        var abc1 = PFUser.current()!.objectId as! String
        let query2 = PFQuery(className:"UsersCardInfoTable")
        query2.whereKey("StringVersionUser", equalTo: abc1)
        query2.findObjectsInBackground { (objects1: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print("Error haiii")
            } else if let objects1 = objects1 {
                // The find succeeded.
                print("Successfully retrieved \(objects1.count) PHOTOS")
                // Do something with the found objects
                for object in objects1 {
                    let imageFile = object["image"] as! PFFileObject
                    let urlString = imageFile.url!
                    let url = URL(string: urlString)!
                    self.photosStringForImage.append(urlString)
                    
                }
            }
        }
    }

    func calculations()
    {
        price = Float(priceGetter.text!) ?? 0.0
        
        print(price)
        print(rowSelected)
        
        var abc = PFUser.current()!.objectId as! String
        let query = PFQuery(className:"UsersCardInfoTable")
        query.whereKey("StringVersionUser", equalTo: abc)
        query.order(byDescending: rowSelected)
//        query.findObjectsInBackground { (usersCards, error) in
//            if usersCards != nil {
//                self.usersCards = usersCards!
//            }
//        }
//
        print("TMKOC")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
                    if let error = error {
                        // Log details of the failure
                        print(error.localizedDescription)
                    } else if let objects = objects {
                        // The find succeeded.
                        print("Successfully retrieved \(objects.count) cards.")
                        // Do something with the found objects
                        for object in objects {
                            print(object["CardName"] as! String)
                            if(object["RewardCategory"] as! String == "Cashback")
                            {
                                self.cashbackDict[object["CardName"] as! String] = object[self.rowSelected] as! Int
                                let imageFile = object["image"] as! PFFileObject
                                let urlString = imageFile.url!
                                let url = URL(string: urlString)!
                                self.cashBackurlStringForImage.append(urlString)
                                print(urlString)
                                print(type(of: urlString))
                                self.cashBackrewardCato.append(object["RewardCategory"] as! String)
                                
                            }
                            if(object["RewardCategory"] as! String == "Points")
                            {
                                self.pointsDict[object["CardName"] as! String] = object[self.rowSelected] as! Int
                                let imageFile = object["image"] as! PFFileObject
                                let urlString = imageFile.url!
                                let url = URL(string: urlString)!
                                self.pointsurlStringForImage.append(urlString)
                                print(urlString)
                                print(type(of: urlString))
                                self.pointsrewardCato.append(object["RewardCategory"] as! String)
                            }
                            if(object["RewardCategory"] as! String == "Miles")
                            {
                                self.milesDict[object["CardName"] as! String] = object[self.rowSelected] as! Int
                                let imageFile = object["image"] as! PFFileObject
                                let urlString = imageFile.url!
                                let url = URL(string: urlString)!
                                self.milesStringForImage.append(urlString)
                                print(urlString)
                                print(type(of: urlString))
                                self.milesrewardCato.append(object["RewardCategory"] as! String)
                                let rewardCat = object["RewardCategory"] as! String
                            }
                        }
                        //prints
                        
                        //Cashback
                        print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
                        for d in 0..<self.cashbackDict.count{
                            print("cashback \(self.cashbackDict.elements[d].key): \(self.cashbackDict.elements[d].value)")
                            var cashback = (Float(self.cashbackDict.elements[d].value)/100)*self.price
                            self.calculatedCashBack[self.cashbackDict.elements[d].key] = cashback
                        }
                        for e in 0..<self.calculatedCashBack.count {
                           print("CashBackCalc \(self.calculatedCashBack.elements[e].key): \(self.calculatedCashBack.elements[e].value)")
                        }
                        print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
                        //Cashback
        //                for (key, value) in self.cashbackDict {
        //                   print("Cashback \(key): \(value)")
        //                    var cashback = (Float(value)/100)*self.price
        //                    self.calculatedCashBack[key] = cashback
        //                }
        //                for (key, value) in self.calculatedCashBack {
        //                   print("CashbackCalc \(key): \(value)")
        //                }
        //                print("--------")
                        
                        //Points
                        print("***********")
                        for d in 0..<self.pointsDict.count{
                            print("points \(self.pointsDict.elements[d].key): \(self.pointsDict.elements[d].value)")
                            var points = Float(self.pointsDict.elements[d].value)*self.price
                            self.calculatedPoints[self.pointsDict.elements[d].key] = points
                        }
                        for e in 0..<self.calculatedPoints.count {
                           print("pointsCalc \(self.calculatedPoints.elements[e].key): \(self.calculatedPoints.elements[e].value)")
                        }
                        print("***********")
                        
                        
        //                for (key, value) in self.pointsDict {
        //                   print("points \(key): \(value)")
        //                    var points = Float(value)*self.price
        //                    self.calculatedPoints[key] = points
        //                }
        //                for (key, value) in self.calculatedPoints {
        //                   print("pointsCalc \(key): \(value)")
        //                }
                        
                        //Miles
                        print("MMMMMMMMMMMMMMMMMMMMMMMMMMMMM")
                        for d in 0..<self.milesDict.count{
                            print("miles \(self.milesDict.elements[d].key): \(self.milesDict.elements[d].value)")
                            var miles = Float(self.milesDict.elements[d].value)*self.price
                            self.calculatedMiles[self.milesDict.elements[d].key] = miles
                        }
                        for e in 0..<self.calculatedMiles.count {
                           print("milesCalc \(self.calculatedMiles.elements[e].key): \(self.calculatedMiles.elements[e].value)")
                        }
                        print("MMMMMMMMMMMMMMMMMMMMMMMMMMMMM")
                        
                        //Miles
        //                for (key, value) in self.milesDict {
        //                   print("Miles \(key): \(value)")
        //                    var Miles = Float(value)*self.price
        //                    self.calculatedMiles[key] = Miles
        //                }
        //                for (key, value) in self.calculatedMiles {
        //                   print("MilesCalc \(key): \(value)")
        //                }
        //                print("--------")
                        
                        
                        print("OOOOOOOOOOOOOOOOOOOOOO")
                        //Filling Final Dictionary for printing
                        if(self.calculatedCashBack.isEmpty == false)
                        {
                            homeViewController.finalwa.finals[self.calculatedCashBack.elements[0].key] = self.calculatedCashBack.elements[0].value
                            self.finalsrewardCato.append(self.cashBackrewardCato[0])
                            self.finalsStringForImage.append(self.cashBackurlStringForImage[0])
                        }
                        if(self.calculatedPoints.isEmpty == false)
                        {
                            homeViewController.finalwa.finals[self.calculatedPoints.elements[0].key] = self.calculatedPoints.elements[0].value
                            self.finalsrewardCato.append(self.pointsrewardCato[0])
                            self.finalsStringForImage.append(self.pointsurlStringForImage[0])
                        }
                        if(self.calculatedMiles.isEmpty == false)
                        {
                            homeViewController.finalwa.finals[self.calculatedMiles.elements[0].key] = self.calculatedMiles.elements[0].value
                            self.finalsrewardCato.append(self.milesrewardCato[0])
                            self.finalsStringForImage.append(self.milesStringForImage[0])
                        }
                        ///
                        if(self.calculatedCashBack.isEmpty == false)
                        {
                            for e in 1..<self.calculatedCashBack.count {
                                homeViewController.finalwa.finals[self.calculatedCashBack.elements[e].key] = self.calculatedCashBack.elements[e].value
                                self.finalsrewardCato.append(self.cashBackrewardCato[e])
                                self.finalsStringForImage.append(self.cashBackurlStringForImage[e])
                            }
                        }
                        if(self.calculatedPoints.isEmpty == false)
                        {
                            for f in 1..<self.calculatedPoints.count {
                                homeViewController.finalwa.finals[self.calculatedPoints.elements[f].key] = self.calculatedPoints.elements[f].value
                                self.finalsrewardCato.append(self.pointsrewardCato[f])
                                self.finalsStringForImage.append(self.pointsurlStringForImage[f])
                            }
                        }
                        if(self.calculatedMiles.isEmpty == false)
                        {
                            for g in 1..<self.calculatedMiles.count {
                                homeViewController.finalwa.finals[self.calculatedMiles.elements[g].key] = self.calculatedMiles.elements[g].value
                                self.finalsrewardCato.append(self.milesrewardCato[g])
                                self.finalsStringForImage.append(self.milesStringForImage[g])
                            }
                        }
                        for h in 0..<homeViewController.finalwa.finals.count {
                            print("Finalssss \(homeViewController.finalwa.finals.elements[h].key): \(homeViewController.finalwa.finals.elements[h].value)")
                        }
                        print("OOOOOOOOOOOOOOOOOOOOOO")
                    }
                }
            }
    
    @IBAction func resultButton(_ sender: Any?)
    {
        Toast.show(message: "We are working on it", controller: self)
        calculations()
        DispatchQueue.main.asyncAfter(deadline:.now() + 2.0, execute: {
            self.performSegue(withIdentifier: "toResultScreen", sender:self)
        })
        
        //[homeViewController.finalwa.finals, self.finalsrewardCato, self.finalsStringForImage]
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        GIDSignIn.sharedInstance.signOut()
        PFUser.logOut()
        self.performSegue(withIdentifier: "logoutToSignIn", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutToSignIn" {
            let controller = segue.destination as! loginViewController
           } else if segue.identifier == "toResultScreen" {
               let destination = segue.destination as! resultViewController
               destination.Milgaya = homeViewController.finalwa.finals
               destination.milgayaRewardCat = self.finalsrewardCato
               destination.milgayaImageUrlString = self.finalsStringForImage
           }
        
    }
}
