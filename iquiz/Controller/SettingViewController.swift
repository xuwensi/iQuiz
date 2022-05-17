//
//  SettingViewController.swift
//  iquiz
//
//  Created by Wensi Xu on 5/15/22.
//

import UIKit

protocol settingActionTeller {
    func fetchData(_ sender: Any)
    func getURL(_ url: String)
}

class SettingViewController: UIViewController {
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
        self.delegate?.getURL(url!)
        self.delegate?.fetchData(sender)
        self.dismiss(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
