//
//  MenuViewController.swift
//  AKSwiftSlideMenu
//
//  Created by Ashish on 21/09/15.
//  Copyright (c) 2015 Kode. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
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
    var arrayMenuOptions = [Dictionary<String,String>]()
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

        pickerView.selectRow(defaultFontNameRow, inComponent: 1, animated: true)
        pickerView.selectRow(defaultFontSizeRow, inComponent: 0, animated: true)
        
        tblMenuOptions.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("id of cat: \(arrayMenuCatList[indexPath.row].id)")
        print("title of cat: \(arrayMenuCatList[indexPath.row].title)")
        print("post count of cat: \(arrayMenuCatList[indexPath.row].post_count)")
        let ListPostForThisCat = self.storyboard!.instantiateViewController(withIdentifier: "List_Post") as! CategoryPosts
        ListPostForThisCat.catId = arrayMenuCatList[indexPath.row].id
        ListPostForThisCat.navTitle = arrayMenuCatList[indexPath.row].title
        self.navigationController!.pushViewController(ListPostForThisCat, animated: true)


            
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(btn)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuCatList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    @IBAction func applyNewFontAndSize(_ sender: Any) {
        helper.saveFontName(NewFontName: newFontNameByUser)
        helper.saveFontSize(NewFontSize: newFontSizeByUser)
        helper.saveFontNameRow(row: defaultFontNameRow)
        helper.saveFontSizeRow(row: defaultFontSizeRow)
        print(helper.getFontName() + helper.getFontSize())
        print("defaultRowForFontName is \(helper.getFontNameRow())  and defaultRowForFontSize is \(helper.getFontSizeRow())")
        pickerView.isHidden = true
        sampleText.isHidden = true
        buApplyFont.isHidden = true
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
            "  text-align: justify;\n" +
            "  direction: rtl;\n" +
            "  line-height: 2.5;\n" +
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
        
        text = text + "من يكتب يقرأ مرتين"
        text = text + "</body></html>"
        sampleText.loadHTMLString(text, baseURL: Bundle.main.bundleURL)

    }

}
