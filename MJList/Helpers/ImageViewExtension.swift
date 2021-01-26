//
//  ImageViewExtension.swift
//  MJList
//
//  Created by Bellinnov on 26/01/21.
//  Copyright © 2021 gaurav. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {

       if self.image == nil{
             self.image = PlaceHolderImage
       }

       URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

           if error != nil {
               print(error ?? "No Error")
               return
           }
           DispatchQueue.main.async(execute: { () -> Void in
               let image = UIImage(data: data!)
               self.image = image
           })

       }).resume()
   }}
