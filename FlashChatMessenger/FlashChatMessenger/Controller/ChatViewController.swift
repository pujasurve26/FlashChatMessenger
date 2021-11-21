//
//  ChatViewController.swift
//  FlashChatMessenger
//
//  Created by Puja Kalpesh Surve on 21/11/21.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tblChatTable: UITableView!
    @IBOutlet weak var txtMessageTextEnter: UITextField!
    
    let db = Firestore.firestore()
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setContents()
    }
    
    func setContents() {
        let btnLogout = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logoutUser))
        btnLogout.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem  = btnLogout
        
        tblChatTable.dataSource = self
        tblChatTable.delegate = self
        
        title = K.appName
        navigationItem.hidesBackButton = true
        
        tblChatTable.register(UINib(nibName: "MessegeCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        loadMessages()
    }
    
    @objc func logoutUser() {
        do {
            let _ = try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch let err {
            print(err.localizedDescription)
        }
        
    }

    func loadMessages() {
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { querysnapshot, error in
            self.messages = []
            
            if let e = error {
                print("There was an issue retriving data from firestore. \(e)")
            } else {
                if let snapshotDocuments = querysnapshot?.documents {
                    
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tblChatTable.reloadData()
                                
                                let indexpath = IndexPath(row: self.messages.count - 1, section: 0)
                                
                                self.tblChatTable.scrollToRow(at: indexpath, at: .top, animated: true)
                            }
                        }
                    }
                    
                }
            }
            
        }
        
    }
    
    @IBAction func btnSendTapped(_ sender: UIButton) {
        
        if let messageBody = txtMessageTextEnter.text, let messageSender = Auth.auth().currentUser?.email
        {
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody, K.FStore.dateField: Date().timeIntervalSince1970]) {
                (error) in
                
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data")
                    
                    DispatchQueue.main.async {
                        self.txtMessageTextEnter.text = ""
                    }
                }
            }
        }
    }
    
}
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! TableViewCell
        cell.lblMsgLebel.text = message.body
         
        if message.sender == Auth.auth().currentUser?.email {
            cell.imgYou.isHidden = true
            cell.imgMe.isHidden = false
            cell.viwMessageBuble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.lblMsgLebel.textColor = UIColor(named: K.BrandColors.purple)
            
        } else {
            cell.imgYou.isHidden = false
            cell.imgMe.isHidden = true
            cell.viwMessageBuble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.lblMsgLebel.textColor = UIColor(named: K.BrandColors.lightPurple)
            
        }
        return cell
        
    }
    
    
}
extension ChatViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tblChatTable.rowHeight
    }
    
}
