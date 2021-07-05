//
//  ViewController.swift
//  MyCart
//
//  Created by Mohammed Ibrahim on 3/7/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var totalCount: UILabel!
    
    @IBOutlet weak var availableCount: UILabel!
    
    @IBOutlet weak var loanedCount: UILabel!
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var LoanedTab: UIStackView!
    
    @IBOutlet weak var AvailableTab: UIStackView!
    
    var dataName = ["Jeans","Pants","Shirt", "Tshirt","Coat","SweatShirt","Sharee","Track Pant","Dry Cloth"]
    var dataImage = ["dress1","dress2","dress3","dress4","dress5","dress6","dress7","dress8","dress9"]
    var loanedName = [String]()
    var loanedImage = [String]()
    var isLoaned : Bool = false
    
    var isAvailabe : Bool = true
    
    var dataModels = [DataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        totalCount.text = "10"
        availableCount.text = String(dataName.count)
        loanedCount.text = String(loanedName.count)
        totalCount.text = String(dataName.count)
        table.delegate = self
        table.dataSource = self
        LoanedTab.isUserInteractionEnabled = true
        let loaned = UITapGestureRecognizer(target: self, action: #selector(self.onLonedClick(_:)))
        LoanedTab.addGestureRecognizer(loaned)
        let available = UITapGestureRecognizer(target: self, action: #selector(self.onAvailableClick(_:)))
        AvailableTab.addGestureRecognizer(available)
        LoanedTab.isUserInteractionEnabled = true
        LoanedTab.backgroundColor = .white
        AvailableTab.backgroundColor = .systemGray6
    }
    
    @objc func onLonedClick(_ sender: UITapGestureRecognizer) {
        isLoaned = true
        isAvailabe = false
        table.reloadData()
        LoanedTab.backgroundColor = .systemGray6
        AvailableTab.backgroundColor = .white
        print("loned")
        availableCount.text = String(dataName.count)
        loanedCount.text = String(loanedName.count)
        table.delegate = self
        table.dataSource = self
      }
    
    @objc func onAvailableClick(_ sender: UITapGestureRecognizer) {
        LoanedTab.backgroundColor = .white
        AvailableTab.backgroundColor = .systemGray6
        isLoaned = false
        isAvailabe = true
        table.reloadData()
        print("availabele")
        availableCount.text = String(dataName.count)
        loanedCount.text = String(loanedName.count)
        table.delegate = self
        table.dataSource = self
      }
    //data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(isLoaned){
            let customCell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
            customCell.myName.text = dataName[indexPath.row]
            customCell.myImages.image = UIImage(named: dataImage[indexPath.row])
            return customCell
        }
        else{
            let customCell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
//            customCell.myName.text = loanedName[indexPath.row]
//            customCell.myImages.image = UIImage(named: loanedImage[indexPath.row])
            return customCell
        }
    }
    
    
    
    //delegate
    private func handleMarkAsFavourite(indexPath: IndexPath) {
        dataName.append(loanedName[indexPath.row])
        dataImage.append(loanedImage[indexPath.row])
        loanedName.remove(at: indexPath.row)
        loanedImage.remove(at: indexPath.row)
        availableCount.text = String(dataName.count)
        loanedCount.text = String(loanedName.count)
        table.reloadData()
       
    }

    private func handleMarkAsUnread(indexPath: IndexPath) {
      
        
        loanedName.append(dataName[indexPath.row])
        loanedImage.append(dataImage[indexPath.row])
        dataName.remove(at: indexPath.row)
        dataImage.remove(at: indexPath.row)
        availableCount.text = String(dataName.count)
        loanedCount.text = String(loanedName.count)
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Remove") { [weak self] (action, view, completionHandler) in
            self?.handleMarkAsFavourite(indexPath: indexPath)
                                            completionHandler(true)
        }
        action.backgroundColor = .systemRed
    
     
        if isLoaned{
            return UISwipeActionsConfiguration(actions: [action])
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView,
                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        // Unread action
        let read = UIContextualAction(style: .normal,
                                       title: "Add") { [weak self] (action, view, completionHandler) in
                                        self?.handleMarkAsUnread(indexPath: indexPath)
                                        completionHandler(true)
        }
        read.backgroundColor = .systemOrange

        let configuration = UISwipeActionsConfiguration(actions: [read])

        if isAvailabe{
            return configuration
        }else{
            return nil
        }
    }

}

