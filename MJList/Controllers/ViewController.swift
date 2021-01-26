//
//  ViewController.swift
//  MJList
//
//  Created by Bellinnov on 26/01/21.
//  Copyright © 2021 gaurav. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var homeTableView: UITableView!
    
    var dataArray = [Results]()
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = []
        
        homeTableView.tableFooterView = UIView()
        
        homeTableView.estimatedRowHeight = 130
        homeTableView.rowHeight = UITableView.automaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavBar()
        getData()
    }
    
    func configureNavBar(){
        self.title = "Albums"
    }
    
    func getData(){
        
        var request = URLRequest(url: URL(string: "https://itunes.apple.com/search?term=Michael+jackson")!)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(MjClass.self, from: data!)
                print(responseModel)
                
                let data = responseModel.results ?? []
                let dataCount = responseModel.resultCount ?? 0
                
                self.dataArray.removeAll()
                if dataCount > 0{
                for i in 0...data.count - 1{
                    let dataValue = data[i]
                    self.dataArray.append(dataValue)
                }
                    DispatchQueue.main.async {
                         self.homeTableView.reloadData()
                    }
                   
                }
            } catch {
                print("JSON Serialization error")
            }
        }).resume()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homecell", for: indexPath) as! HomeTableViewCell
        
        let item = self.dataArray[indexPath.row]
        cell.nameLbl.text = item.artistName ?? ""
        cell.descriptionLbl.text = item.collectionArtistName ?? ""
        let currency = item.currency ?? ""
        cell.priceLbl.text = currency + " " + String(format: "%.2f", item.collectionPrice ?? 0)
        
        
        let urlString = item.artworkUrl100 ?? ""
        cell.imageView?.imageFromServerURL(urlString: urlString, PlaceHolderImage: UIImage(named: "Mj")!)
        return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Dvc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let item = self.dataArray[indexPath.row]
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.dataArray = item
        self.navigationController?.pushViewController(Dvc, animated: true)
    }
    


}


