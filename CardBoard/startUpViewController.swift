//
//  startUpViewController.swift
//  CardBoard
//
//  Created by Divyansh Singh on 02/11/22.
//

import UIKit

class startUpViewController: UIViewController {

    @IBOutlet weak var startUpCollectionView: UICollectionView!
    var slides: [onBoardingSlide] = []
    
    var currentPage = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [onBoardingSlide(image: (UIImage(imageLiteralResourceName: "num1"))), onBoardingSlide(image: (UIImage(imageLiteralResourceName: "num2"))),onBoardingSlide(image: (UIImage(imageLiteralResourceName: "num3"))), onBoardingSlide(image: (UIImage(imageLiteralResourceName: "num4")))]
        // Do any additional setup after loading the view.
    }
   
    
    @IBOutlet weak var startUpPageControl: UIPageControl!
    
    @IBAction func startUpSignUpButton(_ sender: Any) {
        print("OnBoarding SignUp Button Clicked")
    }
    
    @IBAction func startUpSignInButton(_ sender: Any) {
        print("OnBoarding SignIn Button Clicked")
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
extension startUpViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: startUpCollectionViewCell.identifier, for: indexPath) as! startUpCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        startUpPageControl.currentPage = currentPage
    }
}
