//
//  resultViewController.swift
//  CardBoard
//
//  Created by Divyansh Singh on 07/12/22.
//

import UIKit
import OrderedCollections
import Parse
import Alamofire
import AlamofireImage

class resultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var resultTableView: UITableView!

    var finalCards = [PFObject]()
    var milgayaRewardCat = [String]()
    var milgayaImageUrlString = [String]()
    var checker = 0
    
    var Milgaya: OrderedDictionary<String, Float> = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        resultTableView.delegate = self
        resultTableView.dataSource = self
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        // Do any additional setup after loading the view.
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped left - back to home screen from result")
            self.performSegue(withIdentifier: "resultToHome", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("LALALALALLALALALALALALALALA")
        print(Milgaya.isEmpty)
        for h in 0..<Milgaya.count {
            print("Milagyaa \(Milgaya.elements[h].key): \(Milgaya.elements[h].value)")
        }
        print("LALALALALLALALALALALALALALA")
        
        print("ZZZZZZZZZZZZZZZZZZ")
        for abc in milgayaRewardCat{
            print(abc)
        }
        print("ZZZZZZZZZZZZZZZZZZ")
        print("AAAAAAAAAAAAAAAAAA")
        for ab in milgayaImageUrlString{
            print(ab)
        }
        print("AAAAAAAAAAAAAAAAAA")
//
//        let query = PFQuery(className: "AllCardInfoTable")
//        query.includeKey("objectId")
//        //Remember the Query Limit
//        query.limit = 8
//
//        query.findObjectsInBackground { (finalCards, error) in
//            if finalCards != nil {
//                self.finalCards = finalCards!
//                self.resultTableView.reloadData()
//            }
//        }
    }
//    func abc(){
//        let delayTime = DispatchTime.now()+2.0
//        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
//            for i in 0..<self.Milgaya.count{
//                for cards in self.finalCards
//                {
//                    if(self.Milgaya.keys[i] == cards["CardName"] as! String )
//                    {
//                        print("aagye bhai",cards["RewardCategory"] as! String)
//                        //                    cell.rewardsType.text = cards["RewardCategory"] as! String
//
//                        self.rewardCat.append(cards["RewardCategory"] as! String)
//                        break
//
//                    }
//                }
//            }
//        })
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Milgaya.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"resultsTableViewCell") as! resultsTableViewCell
        
//        if(checker==0){
//            abc()
//        }
//
//
//        let r = rewardCat
        let k = Milgaya.keys
        let v = Milgaya.values
        let card = k[indexPath.row]
        let values = v[indexPath.row]
        let rewardso = milgayaRewardCat[indexPath.row]
        let picureo = milgayaImageUrlString[indexPath.row]
        
//        let firstElements : [String]
//        firstElements = Array(r.prefix(k.count))
//        //print(firstElements.count)
//        print(indexPath.row)
        //let rewardTy = firstElements[indexPath.row]
        cell.cardName.text = card
        if(rewardso == "Cashback"){
            //cell.rewardsType.textColor = UIColor.green
            let rounded = round(values * 1000)/1000.0
            var str = "$" + String(describing: rounded) + " " + rewardso
            cell.rewardsValue.text = str
            cell.rewardsValue.textColor = UIColor.green
        }
        if(rewardso == "Points"){
            //cell.rewardsType.textColor = UIColor.green
            var myIntValue:Int = Int(values)
            var str = String(describing: myIntValue) + " " + rewardso
            cell.rewardsValue.text = str
            cell.rewardsValue.textColor = UIColor.yellow
        }
        if(rewardso == "Miles"){
            //cell.rewardsType.textColor = UIColor.green
            var myIntValue:Int = Int(values)
            var str = String(describing: myIntValue) + " " + rewardso
            cell.rewardsValue.text = str
            cell.rewardsValue.textColor = UIColor.systemBlue
        }
        
        let urlo = URL(string: picureo)!
        cell.cardImages.af.setImage(withURL: urlo)
        
        
        
        
        
        
        
        return cell
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
