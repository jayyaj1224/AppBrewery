//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

let db = Firestore.firestore()

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var inputViewBottom: NSLayoutConstraint!
    
   
    var messages: [Message] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        

        tableView.dataSource = self
        messageTextfield.delegate = self
        navigationItem.hidesBackButton = true
        title = K.titleText
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            
            self.messages = []
            
            if let e = error {
                print("Ther was an issue retrieving data from Firestore: \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody )
                            self.messages.append(newMessage)
                             
                            DispatchQueue.main.async{
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if messageTextfield.text != "" {
            messageTextfield.endEditing(true)
            saveMessage()
            messageTextfield.text = ""
        }
    }

//    @IBAction func tapped(_ sender: Any) {
//        print("tapped")
//        messageTextfield.resignFirstResponder()
//    }
//
    
    
    @IBAction func LogOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: Failed", signOutError)
        }
    }
    
    func saveMessage() {
        
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("successfully saved data. ")
                }
            }
        }
    }
    

}




//UITableViewDataSource : responsible for populating the table view
//MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftimageView.isHidden = true
            cell.rightimageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor.black
        } else {
            cell.leftimageView.isHidden = false
            cell.rightimageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor.white
        }
       
        return cell
    }
    
}
//
//extension ChatViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
//}

//MARK: - UITextFieldDelegate

extension ChatViewController: UITextFieldDelegate  {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if messageTextfield.text != "" {
            saveMessage()
            messageTextfield.text = ""
            textField.resignFirstResponder()
        }
        return true
    }
}





//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        SearchTextField.endEditing(true)
//        return true //입력된 필드에서 바로 true를 리턴하여, 해당 함수 실행
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        // hey VC, the user stoped editing
//        guard let city = SearchTextField.text else {return}
//        weatherManager.(cityNmae: city)
//        SearchTextField.text = ""
//    }
//
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        // hey the user start editing. should I allow?
//        // User가 잘못된 값을 입력하거나, 아예 하지 않은 경우
//        if textField.text != ""{
//            return true
//        } else {
//            textField.placeholder = "Type something here"
//            return false
//        }
//    }
//}

//extension ChatViewController {
//    @objc private func adjustInputView(noti: Notification) {
//        guard let userInfo = noti.userInfo else { return }
//        // TODO: 키보드 높이에 따른 인풋뷰 위치 변경
//        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
//        
//        if noti.name == UIResponder.keyboardWillShowNotification {
//            let adjustmentHeight = keyboardFrame.height - view.safeAreaInsets.bottom //노치부분
//            inputViewBottom.constant = adjustmentHeight
//        } else {
//            inputViewBottom.constant = 0
//        }
//    }
//}
