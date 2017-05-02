//
//  ProfileVC.swift
//  Expa Guides
//
//  Created by Quintin Gunter on 5/1/17.
//  Copyright © 2017 Quintin Gunter. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var saveButtonSet: UIButton!
    
    //Save
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //Load
    @IBOutlet weak var userNameLoad: UILabel!
    @IBOutlet weak var emailLoad: UILabel!
    @IBOutlet weak var passwordLoad: UILabel!
    
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        // Generate text to store in database
        let userNameSave = userNameField.text!
        let emailSave = emailField.text!
        let passwordSave = passwordField.text!
        
        // Get file manager needed to work with the file system
        let fileManager = FileManager.default
        var sqliteDatabase: OpaquePointer? = nil
        var databaseUrl: URL? = nil
        
        do {
            let baseUrl = try
                fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            databaseUrl = baseUrl.appendingPathComponent("Register.sqlite")
        } catch {
            print(error)
        }
        
        if let databaseUrl = databaseUrl {
            let flags = SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE
            let status = sqlite3_open_v2(databaseUrl.absoluteString.cString(using: String.Encoding.utf8)!, &sqliteDatabase, flags, nil)
           
            // Create SQLite table if it doesn't exist
            if status == SQLITE_OK {
                let errorMsg: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>! = nil
                let sqlStatement = "create table if not exists Register (ID Integer Primary key AutoIncrement, UserName Text, Email Text, Password Text);"
                if sqlite3_exec(sqliteDatabase, sqlStatement, nil, nil, errorMsg) == SQLITE_OK {
                    print("Table was created")
                } else {
                    print("Failed to create table")
                }
                
                // Insert data into table row
                var statement: OpaquePointer? = nil
                let insertStatement = "insert into Register (UserName, Email, Password) values ('\(userNameSave)', '\(emailSave)', '\(passwordSave)');"
                sqlite3_prepare_v2(sqliteDatabase, insertStatement, -1, &statement, nil)
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Row inserted")
                } else {
                    print("Row not inserted")
                }
                sqlite3_finalize(statement)
            }
        }
        self.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButtonSet.layer.cornerRadius = 10
        self.hideKeyboardWhenTappedAround()
    
        
        // Load saved data
        let fileManager = FileManager.default
        var sqliteDatabase: OpaquePointer? = nil
        var databaseUrl: URL? = nil
        
        do {
            let baseUrl = try
                fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            databaseUrl = baseUrl.appendingPathComponent("Register.sqlite")
        } catch {
            print(error)
        }
        
        if let databaseUrl = databaseUrl {
            let flags = SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE
            let status = sqlite3_open_v2(databaseUrl.absoluteString.cString(using: String.Encoding.utf8)!, &sqliteDatabase, flags, nil)
            
            // Create SQLite table if it doesn't exist
            if status == SQLITE_OK {
                let errorMsg: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>! = nil
                let sqlStatement = "create table if not exists Register (ID Integer Primary key AutoIncrement, UserName Text, Email Text, Password Text);"
                if sqlite3_exec(sqliteDatabase, sqlStatement, nil, nil, errorMsg) == SQLITE_OK {
                    print("Table was created")
                } else {
                    print("Failed to create table")
                }
                
                // Read data from SQLite database
                var selectStatement: OpaquePointer? = nil
                let selectSql = "select * from Register"
                if sqlite3_prepare_v2(sqliteDatabase, selectSql, -1, &selectStatement, nil) == SQLITE_OK {
                    while sqlite3_step(selectStatement) == SQLITE_ROW {
                        //let rowId = sqlite3_column_int(selectStatement, 0)
                        let savedUserName = sqlite3_column_text(selectStatement, 1)
                        let savedEmail = sqlite3_column_text(selectStatement, 2)
                        let savedPassword = sqlite3_column_text(selectStatement, 3)
                        
                        let userNameString = savedUserName
                        let emailString = savedEmail
                        let passwordString = savedPassword
                        
                        if let userNameString = userNameString, let emailString = emailString, let passwordString = passwordString {
                            userNameLoad.text = ("UserName: \(String (cString: userNameString))")
                            emailLoad.text = ("Email: \(String (cString: emailString))")
                            passwordLoad.text = ("Password: \(String (cString: passwordString))")
                        }
                        //savedInput.numberOfLines = 0
                        //savedInput.lineBreakMode = NSLineBreakMode.byWordWrapping
                    }
                }
                sqlite3_finalize(selectStatement)
            }
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//Hide Keyboard ext.
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
