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

class resultViewController: UIViewController {

    var Milgaya: OrderedDictionary<String, Float> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("LALALALALLALALALALALALALALA")
        print(Milgaya.isEmpty)
        for h in 0..<Milgaya.count {
            print("Milagyaa \(Milgaya.elements[h].key): \(Milgaya.elements[h].value)")
        }
        print("LALALALALLALALALALALALALALA")
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
