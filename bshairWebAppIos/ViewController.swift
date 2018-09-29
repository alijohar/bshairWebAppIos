//
//  ViewController.swift
//  bshairWebAppIos
//
//  Created by johar on 9/16/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var listOfNews: UITableView!
    
    var listOFNewsTemp = ["افتتاح مسجد في القطيف", "افتتاح مسجد في القطيف","افتتاح مسجد في القطيف","افتتاح مسجد في القطيف"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()

        // Add NavigationBar
        setupNavigationBarItems()
        // Do any additional setup after loading the view, typically from a nib.
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
        myCell.newsTitle.text = listOFNewsTemp[indexPath.row]

        return myCell
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

}

