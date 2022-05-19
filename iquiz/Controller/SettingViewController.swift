//
//  SettingViewController.swift
//  iquiz
//
//  Created by Wensi Xu on 5/15/22.
//
import Foundation
import UIKit
import os.log

protocol settingActionTeller {
    func fetchData(_ sender: Any)
    func getURL(_ url: String)
}

class SettingViewController: UIViewController, UITextFieldDelegate {
    var delegate: settingActionTeller?
    @IBOutlet weak var urlLabel: UITextField!
    @IBAction func fetchData(_ sender: Any) {
        let url = urlLabel.text
        if url == nil || url == "" {
            let alert = UIAlertController(title: "URL Field Alert", message: "URL cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: { _ in
                NSLog("\"OK\" pressed.")
            }))
            self.present(alert, animated: true, completion: {
                NSLog("The completion handler fired")
            })
        }
        
        let archivePath = NSHomeDirectory() + "/Documents/scores.archive"
        let nsScores = url!
        do {
            try nsScores.write(toFile: archivePath, atomically: true, encoding: .utf8)
        } catch {
            print("error writing url to file")
        }
   
        self.delegate?.getURL(url!)
        self.delegate?.fetchData(sender)
        self.dismiss(animated: true)
        
    }
    
    private func textFieldShouldReturn(textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlLabel.delegate = self
        let archiveURL = URL(fileURLWithPath: NSHomeDirectory() + "/Documents/scores.archive")
        do {
            let readUrl = try String(contentsOf: archiveURL)
            urlLabel.text = readUrl
        } catch {
            print("error reading URL")
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

}
