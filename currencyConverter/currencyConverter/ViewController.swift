//
//  ViewController.swift
//  currencyConverter
//
//  Created by mohamed zead on 9/13/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var clickLabel: UILabel!
    @IBOutlet weak var clickIcon: UIImageView!
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        clickLabel.center.y += view.bounds.height
         self.clickIcon.center.y += self.view.bounds.height
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewIsTapped)))
    }
    
   @objc func viewIsTapped(){
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let HomeVC = storyBoard.instantiateViewController(withIdentifier: "homeVC")
    self.presentInCustom(HomeVC)

    }
        
    override func viewWillAppear(_ animated: Bool) {
    
        UIView.animate(withDuration: 1.5, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.repeat, .curveEaseInOut], animations: {
            self.clickIcon.center.y -= self.view.bounds.height
        }, completion: nil)
        
        
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseInOut, animations: {
            self.clickLabel.center.y -= self.view.bounds.height
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}
extension ViewController{
    
    func presentInCustom(_ viewControllerToPresent : UIViewController){
        let transition = CATransition()
        transition.duration = 1
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
       
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(viewControllerToPresent, animated: false, completion: nil)
        
    }
    
}

