//
//  ViewController.swift
//  iquiz
//
//  Created by Wensi Xu on 5/7/22.
//
import Foundation
import Network
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, settingActionTeller {
    let initialUrl = "https://tednewardsandbox.site44.com/questions.json"
    let monitor = NWPathMonitor()
    var fetchedURL = ""
    func getURL(_ url: String) {
        fetchedURL = url
    }
    
    func fetchData(_ sender: Any) {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Connected")
                self.fetchQuiz(self.fetchedURL)
            } else {
                print("Disconnected")
                let alert = UIAlertController(title: "Network Alert", message: "Network Disconnected", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK",
                                              style: .default,
                                              handler: { _ in
                    NSLog("\"OK\" pressed.")
                }))
                self.present(alert, animated: true, completion: {
                    NSLog("network alert fired")
                })
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        monitor.cancel()
    }
    
    final let TABLE_ROW_HEIGHT = 80.0
    var quizs : [Quizs] = []
    let images : [String] = ["math", "marvel", "science"]
    
    @IBOutlet weak var quizTableViewPlaceHolder: UITableView!
    
    private func setUpTableView() {
        quizTableViewPlaceHolder.delegate = self
        quizTableViewPlaceHolder.dataSource = self
        let quizTableViewNib = UINib(nibName: "itemQuizTableViewCell", bundle: nil)
        quizTableViewPlaceHolder.register(quizTableViewNib, forCellReuseIdentifier: "itemQuizTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemQuizTableViewCell", for: indexPath) as! itemQuizTableViewCell
        cell.iconImageView.image = UIImage(named: images[indexPath.row])
        cell.titleLabel.text = quizs[indexPath.row].title
        cell.descriptionLabel.text = quizs[indexPath.row].desc
        cell.iconImageView.layer.cornerRadius = 5.0
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TABLE_ROW_HEIGHT
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let questionVC = storyboard?.instantiateViewController(withIdentifier: "questionVC") as? QuestionViewController {
            questionVC.correctNum = 0
            questionVC.quizData = quizs
            questionVC.indexPathRow = indexPath.row
            self.navigationController?.pushViewController(questionVC, animated: true)
        }
    }
    
    private func readLocalJson(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingVC = segue.destination as? SettingViewController {
            settingVC.delegate = self
        }
    }
    
    private func fetchQuiz(_ inputURL: String) {
        let url = URL(string: inputURL)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("error: \(error!)")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            if let quizData = try? JSONDecoder().decode([Quizs].self, from: data) {
                DispatchQueue.main.async {
                    self.quizs = quizData
                    self.setUpTableView()
                    self.quizTableViewPlaceHolder.reloadData()
                }
            } else {
                print("Cannot parse data")
                return
            }
            
        }
        
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                let alert = UIAlertController(title: "Network Alert", message: "Network Disconnected: Loading Local Data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK",
                                              style: .default,
                                              handler: { _ in
                    NSLog("\"OK\" pressed.")
                }))
                self.present(alert, animated: true, completion: {
                    NSLog("network alert fired")
                })
                if let localData = self.readLocalJson(forName: "questions") {
                    self.quizs = try! JSONDecoder().decode([Quizs].self, from: localData)
                }
            } else {
                self.fetchQuiz(self.initialUrl)
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        monitor.cancel()

//        setUpTableView()
        self.navigationItem.hidesBackButton = true
    }

}

