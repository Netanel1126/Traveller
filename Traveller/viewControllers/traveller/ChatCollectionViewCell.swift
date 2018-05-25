//
//  ChatCollectionViewCell.swift
//  Traveller
//
//  Created by admin on 03/05/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import UIKit

class ChatCollectionViewCell: UICollectionViewCell {
    
    
    let defaultBlueColor = UIColor(red: 0, green: 137/255, blue: 1, alpha: 1)

    let textView:UITextView = {
        let tv = UITextView()
        tv.text = "Test"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.textAlignment = NSTextAlignment.right
        tv.isEditable = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.clear
        tv.textColor = .white
        return tv
    }()
    
    let bubble: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 137/255, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleRightAnchor:NSLayoutConstraint?
    var bubbleLeftAnchor:NSLayoutConstraint?
    
    let profileImageView:UIImageView = {
        let imageView = UIImageView();
        imageView.image = UIImage(named: "user_default")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    func initSubViews(){
        
        addSubview(bubble)
        addSubview(textView)
        addSubview(profileImageView)
        
        //x,y,w,h
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 8).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        //x,y,w,h
        bubbleRightAnchor = bubble.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -8)
        bubbleRightAnchor?.isActive = true
        bubbleLeftAnchor = bubble.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8)
        
        bubble.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubbleWidthAnchor = bubble.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor!.isActive = true
        bubble.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        //x,y,w,h
        textView.leftAnchor.constraint(equalTo: self.bubble.leftAnchor,constant: 8).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: self.bubble.rightAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

