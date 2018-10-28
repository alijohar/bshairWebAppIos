//
//  MenuViewController.swift
//  AKSwiftSlideMenu
//
//  Created by Ashish on 21/09/15.
//  Copyright (c) 2015 Kode. All rights reserved.
//

import UIKit
import MessageUI

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var versionName: UILabel!
    @IBOutlet weak var viewUnderApplyFont: UIView!
    @IBOutlet weak var sampleText: UIWebView!
    @IBOutlet weak var pickerView: UIPickerView!
    /**
    *  Array to display menu options
    */
    @IBOutlet var tblMenuOptions : UITableView!
    
    /**
    *  Transparent button to hide menu
    */
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    
    /**
    *  Array containing menu options
    */
    var HiddenPickerViewStatus:Bool = true
    var arrayOfSectionTitle = ["الإعدادات", "التصانيف"]
    var arrayMenuOptions = [Dictionary<String,String>]()
    var arrayMenuOptionsForSetting = [Dictionary<String,String>]()

    var arrayMenuCatList = [CatIndex]()
    var fontName = ["Andalus.ttf", "DroidArabicKufiRegular.ttf", "AdobeNaskh.ttf"]
    var fontSize = ["75%", "100%", "125%", "150%", "200%"]
    var defaultFontNameRow:Int = helper.getFontNameRow()
    var defaultFontSizeRow:Int = helper.getFontSizeRow()
    /**
    *  Menu button which was tapped to display the menu
    */
    var btnMenu : UIButton!
    var newFontNameByUser:String = helper.getFontName()
    var newFontSizeByUser:String = helper.getFontSize()

    /**
    *  Delegate of the MenuVC
    */
    @IBOutlet weak var buApplyFont: UIButton!
    var delegate : SlideMenuDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenPickerView(status: true)
        setVersionName()
        
        pickerView.selectRow(defaultFontNameRow, inComponent: 1, animated: true)
        pickerView.selectRow(defaultFontSizeRow, inComponent: 0, animated: true)
        
        tblMenuOptions.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    func hiddenPickerView (status:Bool){
        pickerView.isHidden = status
        sampleText.isHidden = status
        buApplyFont.isHidden = status
        viewUnderApplyFont.isHidden = status
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptionsForSetting()
        updateArrayMenuOptions()
    }
    
    func updateArrayMenuOptions(){
        NewsApi.getCatIndex { (error:Error?, catIndex: [CatIndex]?) in
            let allCats = catIndex
            
            
            for item in allCats! {
                if(item.id != 21){
                    self.arrayMenuCatList.append(item)
                    self.arrayMenuOptions.append(["title": item.title!, "icon":"bshair_menu_logo2"])
                }
            }
            self.tblMenuOptions.reloadData()
            
        }
        
    }
    func updateArrayMenuOptionsForSetting(){
        self.arrayMenuOptionsForSetting.append(["title": "إعدادات النص", "icon":"font_size"])
        self.arrayMenuOptionsForSetting.append(["title": "مشاركة التطبيق", "icon":"shareApp"])
        self.arrayMenuOptionsForSetting.append(["title": "اتصل بنا", "icon":"mail"])
        self.arrayMenuOptionsForSetting.append(["title": "تقرير خطأ", "icon":"bug"])

        
            self.tblMenuOptions.reloadData()
            
        
        
    }

    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0
        
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
        })
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!

        if indexPath.section == 0 {
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.layoutMargins = UIEdgeInsets.zero
            cell.preservesSuperviewLayoutMargins = false
            cell.backgroundColor = UIColor.clear
            
            let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
            let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
            
            imgIcon.image = UIImage(named: arrayMenuOptionsForSetting[indexPath.row]["icon"]!)
            lblTitle.text = arrayMenuOptionsForSetting[indexPath.row]["title"]!
            return cell

        }else{
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.layoutMargins = UIEdgeInsets.zero
            cell.preservesSuperviewLayoutMargins = false
            cell.backgroundColor = UIColor.clear
            
            let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
            let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
            
            imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
            lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
            
            return cell


        }
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            if arrayMenuOptionsForSetting[indexPath.row]["title"]! == "إعدادات النص" {
                if HiddenPickerViewStatus == true {
                hiddenPickerView(status: false)
                    HiddenPickerViewStatus = false
                    
                }else {
                    hiddenPickerView(status: true)
                    HiddenPickerViewStatus = true

                }
            }else if arrayMenuOptionsForSetting[indexPath.row]["title"]! == "مشاركة التطبيق" {
                let text = "http://bshaer.net/download"
                
                // set up activity view controller
                let textToShare = [ text ]
                let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                
                // exclude some activity types from the list (optional)
                activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
                
                // present the view controller
                self.present(activityViewController, animated: true, completion: nil)

            }else if arrayMenuOptionsForSetting[indexPath.row]["title"]! == "اتصل بنا" {
                if MFMailComposeViewController.canSendMail() {
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
                    mail.setToRecipients(["info@bshairdammam.com"])
                    mail.setMessageBody("<p>اكتب نصاً</p>", isHTML: true)
                    
                    present(mail, animated: true)
                } else {
                    // show failure alert
                }
            

            }else if arrayMenuOptionsForSetting[indexPath.row]["title"]! == "تقرير خطأ" {
                    if MFMailComposeViewController.canSendMail() {
                        let mail = MFMailComposeViewController()
                        mail.mailComposeDelegate = self
                        mail.setToRecipients(["error@bshairdammam.com"])
                        mail.setMessageBody("<p>اكتب توضيحاً عن الخطأ الحاصل</p>", isHTML: true)
                        
                        present(mail, animated: true)
                    } else {
                        // show failure alert
                    }
            }
            
                
            
    }else {
        let ListPostForThisCat = self.storyboard!.instantiateViewController(withIdentifier: "List_Post") as! CategoryPosts
        ListPostForThisCat.catId = arrayMenuCatList[indexPath.row].id
        ListPostForThisCat.navTitle = arrayMenuCatList[indexPath.row].title
        self.navigationController!.pushViewController(ListPostForThisCat, animated: true)


            
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(btn)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return arrayMenuOptionsForSetting.count

        }else {
            return arrayMenuCatList.count

        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let headerLabel = UILabel(frame: CGRect(x: 30, y: 22, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Droid Arabic Kufi", size: 14)
        headerLabel.textColor = UIColor.gray
        headerLabel.text = self.tableView(self.tblMenuOptions, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayOfSectionTitle[section]
    }
    

    @IBAction func applyNewFontAndSize(_ sender: Any) {
        helper.saveFontName(NewFontName: newFontNameByUser)
        helper.saveFontSize(NewFontSize: newFontSizeByUser)
        helper.saveFontNameRow(row: defaultFontNameRow)
        helper.saveFontSizeRow(row: defaultFontSizeRow)
        print(helper.getFontName() + helper.getFontSize())
        print("defaultRowForFontName is \(helper.getFontNameRow())  and defaultRowForFontSize is \(helper.getFontSizeRow())")
        hiddenPickerView(status: true)
        HiddenPickerViewStatus = true
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 1 {
            return fontName.count
        }else {
            return fontSize.count
        }
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 1 {
            return fontName[row]
        }else {
            return fontSize[row]
            
        }
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        

        if component == 1 {
            
           newFontNameByUser = fontName[row]
            defaultFontNameRow = row

        }else{
            newFontSizeByUser = fontSize[row]
            defaultFontSizeRow = row
        }
        
setSampleContent()
        
    }
    
    func setSampleContent() {
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
            "  text-align: center;\n" +
            "  direction: rtl;\n" +
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
        "}</style>\n\n</head><html><body dir=\"rtl\"; style=\"text-align:center;\">"
        
        text = text + "من يكتب يقرأ مرتين"
        text = text + "</body></html>"
        sampleText.loadHTMLString(text, baseURL: Bundle.main.bundleURL)

    }

    func setVersionName(){
        //First get the nsObject by defining as an optional anyObject
        let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject
        
        //Then just cast the object as a String, but be careful, you may want to double check for nil
        let version = nsObject as! String

        versionName.text = version
    }
}
