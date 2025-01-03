//
//  ViewController.swift
//  demoOfArcBlock
//
//  Created by 董月峰 on 2024/12/19.
//

import UIKit
import SafariServices

let blockPre = "https://www.arcblock.io/blog/zh/"

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style:.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArcblockCell.self, forCellReuseIdentifier: String(describing: ArcblockCell.self))
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 88
        tableView.separatorColor = .white
        return tableView
    }()
    
    lazy var originData:ArcblockJson = {
        var originData = ArcblockJson(countAll: 0, total: 0, data: [])
        if let filePath = Bundle.main.path(forResource: "demoData", ofType: "json") {
            if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
                do {
                    originData = try JSONDecoder().decode(ArcblockJson.self, from: jsonData)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
        return originData
    }()

    // 要展示的数据
    var displayArticles:[Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(self.tableView)
        displayArticles = originData.data
        
        self.title = "ArcBlock"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "menucard"), style: .plain, target: self, action: #selector(filterBlocksMenu))
    }
    
    @objc func filterBlocksMenu() {
        // 弹出筛选框
        showAlert(message: "筛选label、排序。功能弹窗未开发")
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle:.alert)
        let okAction = UIAlertAction(title: "确定", style:.default, handler: { _ in
            })
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        }
    
}

let jumpPre = "https://www.arcblock.io/blog/zh/"
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArcblockCell.self), for: indexPath) as! ArcblockCell
        cell.configItem(item: displayArticles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = displayArticles[indexPath.row]
        let jumpStr = jumpPre + item.id
        guard let url = URL(string: jumpStr) else {
            // 提示跳转问题
            showAlert(message: "跳转链接存在问题")
            return
        }
        let safariViewController = SFSafariViewController(url: url)
        self.navigationController?.pushViewController(safariViewController, animated: true)
    }
    
}

