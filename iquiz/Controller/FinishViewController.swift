//
//  FinishViewController.swift
//  iquiz
//
//  Created by Wensi Xu on 5/11/22.
//

import UIKit

class FinishViewController: UIViewController {
    var correctNum = 0
    var totalNum = 0
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBAction func nextToHome(_ sender: Any) {
        if let mainVC = storyboard?.instantiateViewController(withIdentifier: "mainVC") as? ViewController {
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if correctNum <= totalNum / 2 {
            messageLabel.text = "Try Again!"
        } else if correctNum == totalNum {
            messageLabel.text = "Perfect!"
        } else {
            messageLabel.text = "Almost!"
        }
        scoreLabel.text = "You get \(correctNum) out of \(totalNum) correct!"
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
