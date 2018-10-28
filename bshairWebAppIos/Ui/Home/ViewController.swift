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

class ViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var listOfNews: UITableView!
    var current_page:Int = 1
    var all_page:Int = 2
    var isLoading: Bool = false
    var listOFNewsTemp = [NewsPost]()
    var bannerNews = [NewsPost]()
    lazy var refresher: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        return refresher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfNews.addSubview(refresher)
        customizingCollectionView()
        
        autoScroll()

        addSlideMenuButton()
        if (helper.getFontSize() == "NoFontSize"){
            helper.saveFontSize(NewFontSize: "100%")
        }
        if (helper.getFontSizeRow() == 1000){
            helper.saveFontSizeRow(row: 1)
            
        }

        if (helper.getFontName() == "NoFontName"){
            helper.saveFontName(NewFontName: "DroidArabicKufiRegular.ttf")
        }
        if (helper.getFontNameRow() == 1000){
            helper.saveFontNameRow(row: 1)
            
        }

        // Add NavigationBar
        setupNavigationBarItems()
        // Load data from json
        fetchData()
        fetchBannerData()
    }
    
    func customizingCollectionView(){

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
        secondViewController.author = listOFNewsTemp[indexPath.row].author?.name
        secondViewController.cat = listOFNewsTemp[indexPath.row].categories!
        secondViewController.date = listOFNewsTemp[indexPath.row].date
        secondViewController.numberComments = listOFNewsTemp[indexPath.row].commentCount
        secondViewController.newsImageUrlString = listOFNewsTemp[indexPath.row].thumbnailImages?.large!.url
        secondViewController.newsUrlLink = listOFNewsTemp[indexPath.row].url!
        secondViewController.comments = listOFNewsTemp[indexPath.row].comments!

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
        guard !isLoading else { return }
        
        isLoading = true
        NewsApi.getPosts { (error:Error?, newsPost: [NewsPost]?, lastPage:Int) in
            self.isLoading = false
            if let newsPost = newsPost {
                self.listOFNewsTemp = newsPost
                self.listOfNews.reloadData()
                
                self.current_page = 1
                self.all_page = lastPage
            }
            
            
        }
    }
    
    func loadMore()  {
        guard !isLoading else { return }
        guard Int(current_page) < Int(all_page) else { return }
        
        isLoading = true
        
        NewsApi.getPosts(page: String(current_page+1)) { (error:Error?, newsPost: [NewsPost]?, lastPage:Int) in
            self.isLoading = false
            if let newsPost = newsPost {
                self.listOFNewsTemp.append(contentsOf: newsPost)
                self.listOfNews.reloadData()
                
                self.current_page += 1
                self.all_page = lastPage
            }
            
            
        }

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = listOFNewsTemp.count
        if indexPath.row == count-1{
//            in LastRow
            self.loadMore()
        }
    }
    
    
//    ForCollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MainBanner = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MainBanner
        
        let imageView = cell.imageView
        let urlLargeBanner = bannerNews[indexPath.row].thumbnailImages?.large?.url
//        Convert StringURl with arabic charecters to standard UrlString
        let urlwithPercentEscapes = urlLargeBanner!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlImage = URL(string: urlwithPercentEscapes!)
        
        Nuke.loadImage(with: urlImage!, into: imageView!)


            cell.titleLabel.text = bannerNews[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "News_Detail") as! NewsDetail
        secondViewController.navTitle = bannerNews[indexPath.row].title
        secondViewController.contentNewsDetail = bannerNews[indexPath.row].content!
        secondViewController.newsItemId = bannerNews[indexPath.row].id!
        secondViewController.author = bannerNews[indexPath.row].author?.name
        secondViewController.cat = bannerNews[indexPath.row].categories!
        secondViewController.date = bannerNews[indexPath.row].date
        secondViewController.numberComments = bannerNews[indexPath.row].commentCount
        secondViewController.newsImageUrlString = bannerNews[indexPath.row].thumbnailImages?.large!.url
        secondViewController.newsUrlLink = bannerNews[indexPath.row].url!
        secondViewController.comments = bannerNews[indexPath.row].comments!
        
        self.navigationController!.pushViewController(secondViewController, animated: true)

    }
    func fetchBannerData (){
        NewsApi.getPostsFromTag { (error:Error?, newsBannerPost: [NewsPost]?) in
            if let newsPost = newsBannerPost {
                self.bannerNews = newsPost
                self.collectionView.reloadData()
            }
            
        }
    }
    

    @objc func scrollAutomatically(_ timer1: Timer) {
        
        if let coll  = collectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)!  < bannerNews.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
                
            }
        }
        
    }
    
    
    func autoScroll(){
        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = view.bounds.width
            let itemHeight = layout.itemSize.height
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.invalidateLayout()
        }
    }
    
}

