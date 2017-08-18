//
//  BidViewController.swift
//  BidTacToe
//
//  Created by Tanja Keune on 8/17/17.
//  Copyright © 2017 SUGAPP. All rights reserved.
//

import UIKit

class BidViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var playerXCredits: UILabel!
    
    @IBOutlet weak var playerOCredits: UILabel!
    
    @IBOutlet weak var bidTextField: UITextField!
    
    //  1 - noughts, 2 - crosses
    var activeBidder = 1
    var activeBidO = 0
    var activeBidX = 0
    var OCredits: Int = 0
    var XCredits: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //        bidTextField.delegate = self
        
        UserDefaults.standard.set(100, forKey: "PlayerX")
        UserDefaults.standard.set(100, forKey: "PlayerO")
        
        
        
        if let points = UserDefaults.standard.value(forKey: "PlayerX") {
            
            playerOCredits.text = String(describing: points)
            OCredits = points as! Int
            
        }
        
        if let points = UserDefaults.standard.value(forKey: "PlayerO") {
            
            playerXCredits.text = String(describing: points)
            XCredits = points as! Int
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func bidButtonTapped(_ sender: Any) {
        
        if activeBidder == 1 {
            
            if Int(bidTextField.text!) != nil {
                
                activeBidO = Int(bidTextField.text!)!
                
                //Check if the player has enough credits, if he has continue if not propt agan with an alert
                
                if activeBidO <= OCredits {
                    
                    activeBidder = 2
                    self.bidTextField.text = ""
                    
                } else {
                    //Present alert controler
                    alertMessageOk(title: "Unsufitiant Credids For Your Bid", message: "Check you credids and try to bid again.")
                }
            }
            
        } else {
            if Int(bidTextField.text!) != nil {
                
                activeBidX = Int(bidTextField.text!)!
                
                //Check if the player has enough credits, if he has continue if not propt agan with an alert
                
                if activeBidX <= XCredits {
                    
                    activeBidder = 1
                    self.bidTextField.text = ""
                    //                    Compare the bids
                    if activeBidO > activeBidX {
                        
                        self.OCredits -= activeBidO
                        self.XCredits += activeBidO
                        self.playerXCredits.text = String(self.XCredits)
                        self.playerOCredits.text = String(self.OCredits)
                        
                        
                        alertMessageOk(title: " O Turn", message: "Make your move")
                        
                        
                    } else if activeBidX > activeBidO {
                        
                        self.XCredits -= activeBidX
                        self.OCredits += activeBidX
                        self.playerXCredits.text = String(self.XCredits)
                        self.playerOCredits.text = String(self.OCredits)
                        
                        alertMessageOk(title: " X Turn", message: "Make your move")
                    } else {
                        alertMessageOk(title: "Tie!", message: "Bid again")
                    }
                } else {
                    //Present alert contreller
                    alertMessageOk(title: "Unsufitiant Credids For Your Bid", message: "Check you credids and try to bid again.")
                    
                }
                
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func alertMessageOk(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
}
