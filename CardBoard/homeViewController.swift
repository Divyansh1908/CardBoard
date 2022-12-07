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


class homeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{

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
        // Do any additional setup after loading the view.
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
    
    @IBAction func resultButton(_ sender: Any) {
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
                    }
                    if(object["RewardCategory"] as! String == "Points")
                    {
                        self.pointsDict[object["CardName"] as! String] = object[self.rowSelected] as! Int
                    }
                    if(object["RewardCategory"] as! String == "Miles")
                    {
                        self.milesDict[object["CardName"] as! String] = object[self.rowSelected] as! Int
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
                print("*********************************")
                for d in 0..<self.pointsDict.count{
                    print("points \(self.pointsDict.elements[d].key): \(self.pointsDict.elements[d].value)")
                    var points = Float(self.pointsDict.elements[d].value)*self.price
                    self.calculatedPoints[self.pointsDict.elements[d].key] = points
                }
                for e in 0..<self.calculatedPoints.count {
                   print("pointsCalc \(self.calculatedPoints.elements[e].key): \(self.calculatedPoints.elements[e].value)")
                }
                print("*********************************")
                
                
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
                
                
            }
        }
    }
}
