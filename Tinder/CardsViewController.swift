//
//  CardsViewController.swift
//  Tinder
//
//  Created by Joey Dafforn on 3/4/18.
//  Copyright © 2018 Joey Dafforn. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var asdfView: UIView!
    @IBOutlet weak var ryanImage: UIImageView!
    var cardInitialCenter: CGPoint!
    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragged(_:)))
    
    // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(panGestureRecognizer)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func dragged(_ sender: UIPanGestureRecognizer) {
        var velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        if sender.state == .began {
            cardInitialCenter = ryanImage.center
            //print("Hello")
        } else if sender.state == .changed {
            if (sender.location(ofTouch: 0, in: view).y <= asdfView.frame.height/2) {
                ryanImage.transform = CGAffineTransform(translationX: translation.x, y: 0)
                ryanImage.transform = ryanImage.transform.rotated(by: CGFloat(Double(translation.x)/4 * Double.pi / 180))
            }
            else {
                ryanImage.transform = CGAffineTransform(translationX: translation.x, y: 0)
                ryanImage.transform = ryanImage.transform.rotated(by: CGFloat(-Double(translation.x)/4 * Double.pi / 180))
            }
//            if (translation.x > 250) {
//                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options:[] ,
//                               animations: { () -> Void in
//                                self.ryanImage.center = CGPoint(x: 1000, y: 0)
//                                velocity.x = velocity.x * 100
//                }, completion: nil)
//            }
        } else if sender.state == .ended {
            if (translation.x > 50) {
                ryanImage.transform = CGAffineTransform(translationX: 10000, y: 0)
            }
            if (translation.x < 50) {
                ryanImage.transform = CGAffineTransform(translationX: 10000, y: 0)
            }
            //ryanImage.transform = CGAffineTransform.identity
            ryanImage.center = cardInitialCenter
        }
    }
    
    @IBAction func didTapImage(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "profileSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "profileSegue"){
            let profileDetails = segue.destination as! ProfileViewController
            profileDetails.myImage = self.ryanImage.image
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
