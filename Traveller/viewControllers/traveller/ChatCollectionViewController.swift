//
//  ChatCollectionViewController.swift
//  Traveller
//
//  Created by admin on 03/05/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit

class ChatCollectionViewController: UICollectionViewController,UITextFieldDelegate,UICollectionViewDelegateFlowLayout {
    
     lazy var inputTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.white
        textField.delegate = self
        return textField
    }()
    
    var chatLog = [MessageResponse]()
    let myId = DefaultUser.getUser()?.id
    var users:TripUsers?
    var tabbar:GuideTabBarController?
    var containerViewBottomAnchor:NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 58, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        

        TravellerNotification.localChatNotification.observe { (_) in
            self.chatLog = MessageListener.instance.list
            self.collectionView?.reloadData()
        }
        tabbar = self.tabBarController as! GuideTabBarController
        var tripId = tabbar?.tripId
        users = TripUsers(groupId: tripId!)
        
        TravellerNotification.tripUsersNotification.observe { (_) in
            self.collectionView?.reloadData()
        }
        
        self.chatLog = MessageListener.instance.list
       /* var msgTest = MessageResponse(uid: "Zp9PxvzBs2hI0gGtAFCl3i45JZ53", message: "This is a Test to check how does it look like when a different person is sending a message, TODO check with server how does it look like")
                
        chatLog.append(msgTest)*/
        setupInputComponents()
        setupKeyboardObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupKeyboardObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: .UIKeyboardWillShow , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: .UIKeyboardWillHide , object: nil)
    }
    
    @objc func handleKeyboardWillShow(notification:NSNotification){
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        
        containerViewBottomAnchor?.constant = -keyboardFrame!.height
        UIView.animate(withDuration: keyboardDuration!) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleKeyboardWillHide(notification:NSNotification){
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        
        containerViewBottomAnchor?.constant = -49
        UIView.animate(withDuration: keyboardDuration!) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatLog.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ChatCollectionViewCell
        
        var msg = chatLog[indexPath.item]
        self.setupCell(cell: cell, msg: msg)
        
        return cell
    }
    
    private func setupCell(cell: ChatCollectionViewCell,msg: MessageResponse)
    {
        if msg.uid == myId{
            cell.bubble.backgroundColor = UIColor.gray
            cell.profileImageView.isHidden = true
            cell.bubbleRightAnchor?.isActive = true
            cell.bubbleLeftAnchor?.isActive = false
        }else{
            cell.bubble.backgroundColor = cell.defaultBlueColor
            cell.profileImageView.isHidden = false
            cell.profileImageView.image = users?.usersImages[msg.uid]
            cell.bubbleRightAnchor?.isActive = false
            cell.bubbleLeftAnchor?.isActive = true
        }
        
        cell.bubbleWidthAnchor?.constant = estimatFrameForText(text: msg.message).width + 32
        cell.textView.text = msg.message
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height:CGFloat = 80
        
        let text = chatLog[indexPath.item].message
        height = estimatFrameForText(text: text).height + 20
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    private func estimatFrameForText(text: String)-> CGRect{
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16)] , context: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func setupInputComponents(){
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        
        //x,y,w,h
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        containerViewBottomAnchor = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -49)
        containerViewBottomAnchor?.isActive = true
        
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(hendleSend), for: .touchUpInside)
        sendButton.backgroundColor = UIColor.white
        containerView.addSubview(sendButton)
        
        //x,y,w,h
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        containerView.addSubview(inputTextField)
        
        //x,y,w,h
        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorLineView)
        
        //x,y,w,h
        separatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        separatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    @objc func hendleSend(){
        var msg = MessageResponse(uid: myId! , message: inputTextField.text!)
        if msg.message.isEmpty == false{
            TravellerNotification.serverChatNotification.post(data: msg)
            self.inputTextField.text = ""
        }
        dismissKeyboard()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hendleSend()
        return true
    }
}
