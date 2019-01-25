//
//  NewsDetail.swift
//  bshairWebAppIos
//
//  Created by johar on 9/18/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Nuke
import Firebase

class NewsDetail: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var newsDetailWeb: UIWebView!
    @IBOutlet weak var newsDetailImage: UIImageView!
    
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var CommentsNumber: UIButton!
    @IBOutlet weak var newsAuthorName: UILabel!
    @IBOutlet weak var newsCat: UILabel!
    var navTitle:String?
    var authorName:String?
    var newsItemId:Int?
    var itsArticle:Bool?
    var cat = [NewsCategory]()
    var date:String?
    var author:String?
    var numberComments:Int?
    
    var newsUrlLink:String = ""
    var contentNewsDetail:String = ""
    var newsImageUrlString:String?
    var newFontNameByUser:String = ""
    var newFontSizeByUser:String = ""
    var newsDetailURLString:String?
    var comments = [NewsComments]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Analytics.logEvent("PostViewIOS", parameters: [
            "العنوان": navTitle! as NSObject,
            ])

        setMainImage()
        newFontNameByUser = helper.getFontName()
        newFontSizeByUser = helper.getFontSize()
        // Customize navigationBar
        setupNavigationBarItems()
        setNewsDetailContent()
        setNewsDetailInfo()
        newsDetailWeb.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        switch navigationType {
        case .linkClicked:
            // Open links in Safari
            guard let url = request.url else { return true }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // openURL(_:) is deprecated in iOS 10+.
                UIApplication.shared.openURL(url)
            }
            return false
        default:
            // Handle other navigation types...
            return true
        }

    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupNavigationBarItems(){
        navigationItem.title = navTitle
        let shareNewsButton = UIButton(type: .system)
        shareNewsButton.setImage(#imageLiteral(resourceName: "shareNews"), for: .normal)
        shareNewsButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        shareNewsButton.addTarget(self, action: #selector(NewsDetail.shareURlNewsDetail(_:)), for: UIControlEvents.touchUpInside)
        
        let addCommentsButton = UIButton(type: .system)
        addCommentsButton.setImage(#imageLiteral(resourceName: "addComment"), for: .normal)
        addCommentsButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        addCommentsButton.addTarget(self, action: #selector(NewsDetail.sendCommentButton(_:)), for: UIControlEvents.touchUpInside)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: shareNewsButton), UIBarButtonItem(customView: addCommentsButton)]
        
    }
    
    
    @objc func sendCommentButton(_ sender : UIButton){
        let alertController = UIAlertController(title: "أرسل تعليقاً", message: "", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "إرسال", style: .destructive) { (_) in
            
            //getting the input values from user
            
//            post id should add here
            let post_id = self.newsItemId
            
            
            guard let name = alertController.textFields?[0].text, !name.isEmpty else {return}
            guard let email = alertController.textFields?[1].text, !email.isEmpty else {return}
            guard let content = alertController.textFields?[2].text, !content.isEmpty else {return}
            
            NewsApi.sendComment(post_id: post_id!, name: name, email: email, content: content) {(error:Error?, success:Bool) in
                if success {
                    print("success")
                }else{
                    print("error")
                }
                
            }
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "إلغاء", style: .default) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "الاسم الكريم"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "البريد الإلكتروني"
        }
        alertController.addTextField{ (textField) in
            textField.placeholder = "نص الرسالة"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)

    }
    
    func setMainImage() {
        let imageView = newsDetailImage
        var urlThumbnail:String?
        if newsImageUrlString != nil {
         urlThumbnail = newsImageUrlString
        }
        else {
            urlThumbnail = "http://www.bshaer.net/wp-content/uploads/2018/12/default.jpg"
        }
        let urlwithPercentEscapes = urlThumbnail!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlImage = URL(string: urlwithPercentEscapes!)
        Nuke.loadImage(with: urlImage!, into: imageView!)

        }
    
    func setNewsDetailContent(){
//        For style
        var text = "<head><style type=\"text/css\">\n" +
            "@font-face {\n" +
            " font-family: 'MyCustomFont';\n" +
            " src: url('\(newFontNameByUser)')  format('truetype')  \n" +
            "}\n" +
            "\n" +
            "\n" +
            "body{\n" +
            "  font-size: \(newFontSizeByUser);\n" +
            "  font-family:  'MyCustomFont';\n" +
            "  text-align: justify;\n" +
            "  direction: rtl;\n" +
            "  line-height: 2.5;\n" +
            "}\n" +
            ".link{\n" +
            "    display: inline-block;\n" +
            "    background-color: #7d5abd;\n" +
            "    color: #FFFFFF;\n" +
            "    padding: 6px 25px;\n" +
            "    text-align: center;\n" +
            "    text-decoration: none;\n" +
            "    font-size: 16px;\n" +
        "    opacity: 0.9;" +
            "}\n" +
            ".center{\n" +
            "    text-align: center;\n" +
            "}\n" +

            "\n" +
            "img{\n" +
            "  height: auto;\n" +
            "  width: 100%;\n" +
            "  display: block;\n" +
            "  margin-left: auto;\n" +
            "  margin-right: auto;\n" +
            "}\n" +
            "\n" +
            "h1, h2, h3, h4, h5, h5 {\n" +
            "  color: red;\n" +
            "  text-align: center;\n" +
        "}</style>\n\n</head><html><body dir=\"rtl\"; style=\"text-align:justify;\">"
        let link = "http://bshaer.net/?p=\(newsItemId!)"

        text = text + contentNewsDetail
        let button:String = "<p class =\"center\"><a href=\"\(link)\" class=\"link\">المطالعة في الموقع</a></p>"
        text = text + button + "</body></html>"
        newsDetailWeb.loadHTMLString(text, baseURL: Bundle.main.bundleURL)

    }

    @objc func shareURlNewsDetail(_ sender : UIButton){
        // text to share
        let text = "\(navTitle!)  \n\n\n اقرأ المزيد في \n http://bshaer.net/?p=\(newsItemId!)"
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)

    }

    func setNewsDetailInfo(){
        newsCat.text = cat[0].title
        CommentsNumber.setTitle("\(String(numberComments!)) تعليق", for: .normal)
        if (date?.contains(":"))!{

            let dateWithoutTime = date?.split(separator: " ")
        newsDate.text = String(dateWithoutTime!.first!)
        }
        else{
            newsDate.text = date
        }
        newsAuthorName.text = author
        
    }

    @IBAction func openComments(_ sender: Any) {
        let CommentsViewController = self.storyboard!.instantiateViewController(withIdentifier: "Comments_Detail") as! CommentsView
        CommentsViewController.arrayComments = comments
        CommentsViewController.newsItemId = self.newsItemId
        
        self.navigationController!.pushViewController(CommentsViewController, animated: true)

    }

    func webView(webView: UIWebView!, shouldStartLoadWithRequest request: NSURLRequest!, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == UIWebViewNavigationType.linkClicked {
            UIApplication.shared.openURL(request.url!)
            return false
        }
        return true
    }

}
