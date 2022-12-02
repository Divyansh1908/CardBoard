//
//  addCardViewController.swift
//  CardBoard
//
//  Created by Divyansh Singh on 01/12/22.
//

import UIKit
import Parse
import Alamofire
import AlamofireImage
class addCardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var cards = [PFObject]()
    var selectedCards = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Accessing the AllCardInfoTable
        let query = PFQuery(className: "AllCardInfoTable")
        query.includeKey("objectId")
        //Remember the Query Limit
        query.limit = 10
        
        query.findObjectsInBackground { (cards, error) in
            if cards != nil {
                self.cards = cards!
                self.tableView.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    //Putting cardImage and cardInfo in the cell for each card
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"addCardTableViewCell") as! addCardTableViewCell
        let card = cards[indexPath.row]
        cell.cardInfo.text = card["CardName"] as! String
        let imageFile = card["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.cardImage.af.setImage(withURL: url)
        return cell
    }
    
    //Selecting row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    //Deselecting row
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
        
       
    @IBAction func doneButton(_ sender: Any) {
        selectedCards.removeAll()
        //Get all the selected cards
        if let list = tableView.indexPathsForSelectedRows as? [NSIndexPath]{
            for ipath in list
            {
                selectedCards.append(cards[ipath.row])
            }
        }
        //Putting value of each selected cards in the UsersCardInfoTable
        for cardu in selectedCards
        {
            var UsersCardInfoTable = PFObject (className: "UsersCardInfoTable")
            print("Going in")

            UsersCardInfoTable["UserNameObjectId"] = PFUser.current()!
            UsersCardInfoTable["BankName"] = cardu["BankName"] as! String
            UsersCardInfoTable["CardName"] = cardu["CardName"] as! String
            UsersCardInfoTable["Title1"] = cardu["Title1"] as! String
            UsersCardInfoTable["Title2"] = cardu["Title2"] as! String
            UsersCardInfoTable["Title3"] = cardu["Title3"] as! String
            UsersCardInfoTable["Title4"] = cardu["Title4"] as! String
            UsersCardInfoTable["RewardCategory"] = cardu["RewardCategory"] as! String
            UsersCardInfoTable["Dining"] = cardu["Dining"]
            UsersCardInfoTable["Gas"] = cardu["Gas"]
            UsersCardInfoTable["ECommerce"] = cardu["ECommerce"]
            UsersCardInfoTable["Groceries"] = cardu["Groceries"]
            UsersCardInfoTable["Supermarket"] = cardu["Supermarket"]
            UsersCardInfoTable["Streaming"] = cardu["Streaming"]
            UsersCardInfoTable["Travel"] = cardu["Travel"]
            UsersCardInfoTable["Entertainment"] = cardu["Entertainment"]
            UsersCardInfoTable["Lifestyle"] = cardu["Lifestyle"]
            UsersCardInfoTable["Others"] = cardu["Others"]
            UsersCardInfoTable["image"] = cardu["image"]
            UsersCardInfoTable.saveInBackground
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
        //Goto Next Screen
        self.performSegue(withIdentifier: "gotoHomeScreen", sender: self)
        }
        
    }
    
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        

