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
    final let TABLE_ROW_HEIGHT = 80.0
    var quizs : [Quizs] = []
    let images : [String] = ["math", "marvel", "science"]
    let initialUrl = "https://tednewardsandbox.site44.com/questions.json"
    let monitor = NWPathMonitor()
    var fetchedURL = ""
    var networkConnected = "true"
    
    lazy var refreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:
                         #selector(ViewController.handleRefresh(_:)),
                                     for: UIControl.Event.valueChanged)
            refreshControl.tintColor = UIColor.tintColor
            
            return refreshControl
        }()
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
            self.quizTableViewPlaceHolder.reloadData()
            if networkConnected == "false" {
                let alert = UIAlertController(title: "Network Alert", message: "Network Disconnected: Loading Local Data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK",
                                              style: .default,
                                              handler: { _ in
                    NSLog("\"OK\" pressed.")
                }))
                self.present(alert, animated: true, completion: {
                    NSLog("network alert fired")
                })
            }
            refreshControl.endRefreshing()
        }
    
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
                print("Cannot parse data")
                let alert = UIAlertController(title: "Network Alert", message: "Network Disconnected", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK",
                                              style: .default,
                                              handler: { _ in
                    NSLog("\"OK\" pressed.")
                }))
                self.present(alert, animated: true, completion: {
                    NSLog("network alert fired")
                })
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
                NSLog("Failed to fetch data")
                return
            }
            
        }
        
        task.resume()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quizTableViewPlaceHolder.addSubview(self.refreshControl)

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.fetchQuiz(self.initialUrl)
                self.networkConnected = "true"
            } else {
                self.networkConnected = "false"
                if let localData = self.readLocalJson(forName: "questions") {
                    self.quizs = try! JSONDecoder().decode([Quizs].self, from: localData)
                }
                self.setUpTableView()
                print("disconnected")
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        monitor.cancel()
        
        
//        setUpTableView()
        self.navigationItem.hidesBackButton = true
    }

}

