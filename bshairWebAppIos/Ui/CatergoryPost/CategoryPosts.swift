//
//  CategoryPosts.swift
//  bshairWebAppIos
//
//  Created by johar on 10/22/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import UIKit
import MessageUI
import Nuke

class CategoryPosts: BaseViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate{
    
    @IBOutlet weak var listOfPosts: UITableView!
    var navTitle:String?
    var catId:Int?
    var current_page:Int = 1
    var all_page:Int = 2
    var isLoading: Bool = false
    var listOFNewsTemp = [NewsPost]()
    
    lazy var refresher: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        return refresher
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        listOfPosts.addSubview(refresher)
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
        navigationItem.title = navTitle

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOFNewsTemp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell:CatNewsCell = tableView.dequeueReusableCell(withIdentifier: "CatNewsCell", for: indexPath) as! CatNewsCell
        myCell.newsTitleCat.text = listOFNewsTemp[indexPath.row].title
        let imageView = myCell.newsImageCat
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
    

    
    @objc func fetchData(){
        self.refresher.endRefreshing()
        guard !isLoading else { return }
        
        isLoading = true
        NewsApi.getPostsFromCat(id: String(catId!)) { (error:Error?, newsPost: [NewsPost]?, lastPage:Int) in
            self.isLoading = false
            if let newsPost = newsPost {
                self.listOFNewsTemp = newsPost
                self.listOfPosts.reloadData()
                
                self.current_page = 1
                self.all_page = lastPage
            }
            
            
        }
    }
    
    
    func loadMore()  {
        guard !isLoading else { return }
        guard Int(current_page) < Int(all_page) else { return }
        
        isLoading = true
        
        NewsApi.getPostsFromCat(id: String(catId!), page: String(current_page+1)) { (error:Error?, newsPost: [NewsPost]?, lastPage:Int) in
            self.isLoading = false
            if let newsPost = newsPost {
                self.listOFNewsTemp.append(contentsOf: newsPost)
                self.listOfPosts.reloadData()
                
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
    

}