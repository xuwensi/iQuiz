//
//  ViewController.swift
//  iquiz
//
//  Created by Wensi Xu on 5/7/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    final let TABLE_ROW_HEIGHT = 80.0
    let subjects : [String] = ["Mathematics", "Marvel Super Heroes", "Science"]
    let descriptions : [String] = ["A small multiple-choice quiz used to test knowledge in Mathematics", "Consists of multiple choices about Marvel super heros", "Multiple-choice quiz used to test knowledge in Science field"]
    let images : [String] = ["math", "marvel", "science"]
    
    @IBAction func settingPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Setting Alert", message: "Settings go here.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in
            NSLog("\"OK\" pressed.")
        }))
        self.present(alert, animated: true, completion: {
            NSLog("The completion handler fired")
        })
    }
    
    @IBOutlet weak var quizTableViewPlaceHolder: UITableView!
    
    private func setUpTableView() {
        quizTableViewPlaceHolder.delegate = self
        let quizTableViewNib = UINib(nibName: "itemQuizTableViewCell", bundle: nil)
        quizTableViewPlaceHolder.register(quizTableViewNib, forCellReuseIdentifier: "itemQuizTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemQuizTableViewCell", for: indexPath) as! itemQuizTableViewCell
        cell.iconImageView.image = UIImage(named: images[indexPath.row])
        cell.titleLabel.text = subjects[indexPath.row]
        cell.descriptionLabel.text = descriptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TABLE_ROW_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }


}

