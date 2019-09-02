//
//  ViewController.swift
//  eCommerce_RealmSwift
//
//  Created by Lakshmi on 02/09/19.
//  Copyright © 2019 Personal. All rights reserved.
//

import UIKit
import RealmSwift

class HomePage: UIViewController {

    @IBOutlet weak var addnewCategoryView: UIView!
    @IBOutlet weak var categoryDisplayTable: UITableView!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addBtnName: UIButton!
    
    // create an instance for realm
    
    let realm = try! Realm()
    lazy var categoryList : Results<Category> = {self.realm.objects(Category.self)}() // Create variable for model Category
    
    var selectedCategory : Category! // this is used to update the values
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.addnewCategoryView.isHidden = true
        // Register the custom cell to tableview
        self.categoryDisplayTable.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        
        self.categoryDisplayTable.delegate = self
        self.categoryDisplayTable.dataSource = self
        self.categoryDisplayTable.separatorStyle = .none
        
    }

    @IBAction func AddCategory(_ sender: Any) {
        self.addBtnName.setTitle("Add", for: .normal)
        self.nameTextField.text = ""
        self.descriptionField.text = ""
        self.amountField.text = ""
        self.addnewCategoryView.isHidden = false
    }
    
    @IBAction func disablePopView(_ sender: Any) {
         self.addnewCategoryView.isHidden = true
    }
    
    @IBAction func confirmAddCategory(_ sender: Any) {
        
        if nameTextField.text == "" || descriptionField.text == "" || amountField.text == "" {
            print("please enter all data")
        }
        else if(self.addBtnName.titleLabel?.text == "Add")
        {
            
            // Create a new record in realm database of Category
            try! realm.write {
                let category = Category()
                category.name = nameTextField.text!
                category.desc = descriptionField.text!
                category.amount = amountField.text!
                realm.add(category)
            }
            categoryList = realm.objects(Category.self)
        }
        else if(self.addBtnName.titleLabel?.text == "Update")
        {
            // Updating the previouse record Values
            try! realm.write {
                selectedCategory.name = nameTextField.text!
                selectedCategory.desc = descriptionField.text!
                selectedCategory.amount = amountField.text!
            }
        }
        self.addnewCategoryView.isHidden = true
        self.categoryDisplayTable.reloadData()
        
    }
    
}
extension HomePage : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = self.categoryDisplayTable.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        categoryCell.categoryTitle.text = categoryList[indexPath.row].name
        categoryCell.categoryDescription.text = categoryList[indexPath.row].desc
        categoryCell.categoryAmount.text = categoryList[indexPath.row].amount
        
        return categoryCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = categoryList[indexPath.row]
        self.addnewCategoryView.isHidden = false
    
        self.nameTextField.text = selectedCategory.name
        self.descriptionField.text = selectedCategory.desc
        self.amountField.text = selectedCategory.amount
        
        addBtnName.setTitle("Update", for: .normal)
        
    }
    
    
}

