//
//  DetailViewController.swift
//  MJList
//
//  Created by Bellinnov on 26/01/21.
//  Copyright © 2021 gaurav. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var artistNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var collectionnameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var primaryGenreNameLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var backScrollView: UIScrollView!
    @IBOutlet weak var backView: UIView!
    
    var itembtnBack:UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let item = delegate.dataArray
        
        self.title = "Details"
        artistNameLbl.text = item.artistName ?? ""
        let currency = item.currency ?? ""
        priceLbl.text = currency + " " + String(format:"%.2f",item.collectionPrice ?? 0)
        collectionnameLbl.text = item.collectionName ?? ""
        primaryGenreNameLbl.text = item.primaryGenreName ?? ""
        let date = item.releaseDate ?? ""
        var a:String = ""
        if date != "" {
           
            let result = date.split(separator: "T")
            a = "\(result[0])"
        }
        releaseDateLbl.text = a
        let description = item.description ?? ""
        
        let replacedString = description.replacingOccurrences(of: "<br />", with: "\n")
        let replacedStrings = replacedString.replacingOccurrences(of: "<i>", with: "")
        let replacedStringValue = replacedStrings.replacingOccurrences(of: "</i>", with: "")
        descriptionLbl.text = replacedStringValue
        let urlString = item.artworkUrl100 ?? ""
        profileImage.imageFromServerURL(urlString:urlString , PlaceHolderImage: UIImage(named: "Mj")!)
        
        let btnback = UIButton(type: .custom)
        btnback.setImage(#imageLiteral(resourceName: "back-icon@4x.android"), for: .normal)
        btnback.imageView?.contentMode = .scaleAspectFit
        btnback.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnback.addTarget(self, action: #selector(buttonBackTapped), for: .touchUpInside)
        itembtnBack = UIBarButtonItem(customView: btnback)
        
       
        self.navigationItem.setLeftBarButton(itembtnBack, animated: true)
        
        backScrollView.layoutIfNeeded()
       
    }
   
    @objc func buttonBackTapped(){
        self.navigationController?.popViewController(animated: true)
    }

    



}
