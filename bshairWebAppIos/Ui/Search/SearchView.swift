//
//  SearchView.swift
//  bshairWebAppIos
//
//  Created by johar on 9/18/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import UIKit
import Nuke

class SearchView: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var listOfNewsFromSearch: UITableView!
    var current_page:Int = 1
    var all_page:Int = 2
    var itsArticle:Bool = false
    var isLoading: Bool = false
    var searchedWord:String?
    var listOFNewsTemp = [NewsPost]()
    
    lazy var refresher: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        return refresher
    }()    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfNewsFromSearch.addSubview(refresher)
        searchBar.delegate = self
        // Do any additional setup after loading the view.

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOFNewsTemp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell:searchCell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! searchCell
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
        itsArticle = false
        let tags = listOFNewsTemp[indexPath.row].tags
        
        for item in tags!{
            if item.title == "مقال"{
                itsArticle = true
                
                
            }
        }
        
        if itsArticle{
            let ThirdViewController = self.storyboard!.instantiateViewController(withIdentifier: "News_Detail_Article") as! NewsDetailArticle
            
            
            ThirdViewController.authorName = listOFNewsTemp[indexPath.row].customFields?.authorName![0]
            ThirdViewController.navTitle = listOFNewsTemp[indexPath.row].title
            ThirdViewController.itsArticle = self.itsArticle
            ThirdViewController.contentNewsDetail = listOFNewsTemp[indexPath.row].content!
            ThirdViewController.newsItemId = listOFNewsTemp[indexPath.row].id!
            //                ThirdViewController.author = listOFNewsTemp[indexPath.row].author?.name
            ThirdViewController.cat = listOFNewsTemp[indexPath.row].categories!
            ThirdViewController.date = listOFNewsTemp[indexPath.row].date
            ThirdViewController.numberComments = listOFNewsTemp[indexPath.row].commentCount
            ThirdViewController.newsImageUrlString = listOFNewsTemp[indexPath.row].thumbnailImages?.large!.url
            ThirdViewController.newsUrlLink = listOFNewsTemp[indexPath.row].url!
            ThirdViewController.comments = listOFNewsTemp[indexPath.row].comments!
            
            self.navigationController!.pushViewController(ThirdViewController, animated: true)
            
        }else{

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
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != nil {
            searchedWord = searchBar.text
            fetchData()
        }
        print("please insert atleast one word")
    }
    
    
    @objc func fetchData(){
        self.refresher.endRefreshing()
        guard !isLoading else { return }
        
        isLoading = true
        NewsApi.getPostsFromSearch(s: searchedWord!) { (error:Error?, newsPost: [NewsPost]?, lastPage:Int) in
            self.isLoading = false
            if let newsPost = newsPost {
                self.listOFNewsTemp = newsPost
                self.listOfNewsFromSearch.reloadData()
                
                self.current_page = 1
                self.all_page = lastPage
            }
            
            
        }
    }
    
    
    func loadMore()  {
        guard !isLoading else { return }
        guard Int(current_page) < Int(all_page) else { return }
        
        isLoading = true
        
        NewsApi.getPostsFromSearch(s: searchedWord!, page: String(current_page+1)) { (error:Error?, newsPost: [NewsPost]?, lastPage:Int) in
            self.isLoading = false
            if let newsPost = newsPost {
                self.listOFNewsTemp.append(contentsOf: newsPost)
                self.listOfNewsFromSearch.reloadData()
                
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
