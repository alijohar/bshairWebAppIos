//
//  ViewController.swift
//  bshairWebAppIos
//
//  Created by johar on 9/16/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import UIKit
import MessageUI
import Nuke

class ViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var listOfNews: UITableView!
    var page:String = "1"
    var listOFNewsTemp = [NewsPost]()
    
    lazy var refresher: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        return refresher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfNews.addSubview(refresher)
        addSlideMenuButton()
        

        // Add NavigationBar
        setupNavigationBarItems()
        // Load data from json
        fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupNavigationBarItems(){
        let titleImageView = UIImageView(image:#imageLiteral(resourceName: "ic_menu_bshair"))
        titleImageView.contentMode = UIViewContentMode.scaleAspectFit
        navigationItem.titleView = titleImageView

        // add background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "bk")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .tile), for: .default)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOFNewsTemp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell:NewsCell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
//        titleNews.text = listOFNewsTemp[indexPath.row]
        myCell.newsTitle.text = listOFNewsTemp[indexPath.row].title
        let imageView = myCell.newsImage
        let urlThumbnail = listOFNewsTemp[indexPath.row].thumbnail
        print("gfjhgfghfj \(listOFNewsTemp[indexPath.row])")

//        Convert StringURl with arabic charecters to standard UrlString
        let urlwithPercentEscapes = urlThumbnail!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlImage = URL(string: urlwithPercentEscapes!)
        Nuke.loadImage(with: urlImage!, into: imageView!)

        
        return myCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "News_Detail") as! NewsDetail
        secondViewController.navTitle = listOFNewsTemp[indexPath.row].title
        secondViewController.contentNewsDetail = listOFNewsTemp[indexPath.row].content!
        secondViewController.newsItemId = listOFNewsTemp[indexPath.row].id!
//        secondViewController.newsImageUrlString = listOFNewsTemp[indexPath.row].thumbnailImages?.large!.url
    

        self.navigationController!.pushViewController(secondViewController, animated: true)
        
    }
    
    @IBAction func sendCustomNews(_ sender: Any) {
        sendEmail()
    }
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["news@bshairdammam.com"])
            mail.setMessageBody("<p>اكتب نصاً</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @objc func fetchData(){
        self.refresher.endRefreshing()
        NewsApi.getPosts(page: page) { (error:Error?, newsPost: [NewsPost]?) in
            if let newsPost = newsPost {
                self.listOFNewsTemp = newsPost
                self.listOfNews.reloadData()
            }
            
            
        }
    }
    
    
    

}

