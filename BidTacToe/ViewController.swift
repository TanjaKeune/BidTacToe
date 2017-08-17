//
//  ViewController.swift
//  BidTacToe
//
//  Created by Tanja Keune on 8/16/17.
//  Copyright © 2017 SUGAPP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    1 - noughts, 2 - crosses
    var activePlayer = 1

    var activeGame = true
    
    var gameState = Array(repeating: 0, count: 9)
    
    var winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [ 1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playAgainOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hidePlayAgainButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    @IBAction func buttonPressed(_ sender: AnyObject) {
        
        let activePosition = sender.tag - 1
        
        if gameState[activePosition] == 0 && activeGame {
            
            gameState[activePosition] = activePlayer
            
            if activePlayer == 1 {
                activePlayer = 2
                sender.setImage( UIImage(named: "nought.png"), for: [])
            } else {
                activePlayer = 1
                sender.setImage(UIImage(named: "cross.png"), for: [])
            }
            
            for combination in winningCombinations {
                
                if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[0]] == gameState[combination[2]] {
                    
                    //we have a winner
                    
                    activeGame = false
                    self.winnerLabel.isHidden = false
                    
                    if gameState[combination[0]] == 1 {
                        
                        self.winnerLabel.text = "Noughts Won!"
                    } else {
                        self.winnerLabel.text = "Crosses Won!"
                    }
                    
                   callInPlayAgainButton()
                }
            }
//            Check if there are empty positions to play
            
            var emptyPosituion = false

            for position in gameState {
                
                if position == 0 {
                    
                    emptyPosituion = true
                }
            }
            
            if !emptyPosituion {
                
                activeGame = false
                
                self.winnerLabel.text = "This game is tie!"

                callInPlayAgainButton()
            }
            
        }
    }

    @IBAction func playAgain(_ sender: Any) {
        
        activeGame = true
        
        gameState = Array(repeating: 0, count: 9)
        
        activePlayer = 1
        
        hidePlayAgainButton()
        
        for i in 0 ... 9 {
            
            if let button = view.viewWithTag(i) as? UIButton {
                button.setImage(nil, for: [])
            }
        }
        
    }
    
    func callInPlayAgainButton() {
        
        self.winnerLabel.isHidden = false
        self.playAgainOutlet.isHidden = false
        
        UIView.animate(withDuration: 1, animations: {
            
            self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 500, y: self.winnerLabel.center.y)
            self.playAgainOutlet.center = CGPoint(x: self.playAgainOutlet.center.x + 500, y: self.playAgainOutlet.center.y)
            
        })

    }
    
    func hidePlayAgainButton() {
        
        self.winnerLabel.isHidden = true
        self.playAgainOutlet.isHidden = true
        
        self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x - 500, y: self.winnerLabel.center.y)
        self.playAgainOutlet.center = CGPoint(x: self.playAgainOutlet.center.x - 500, y: self.playAgainOutlet.center.y)
        
    }
}

