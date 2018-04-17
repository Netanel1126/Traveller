//
//  ImageFirebaseStorage.swift
//  Traveller
//
//  Created by Tal Sahar on 12/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//
import UIKit
import Foundation
import FirebaseStorage

class ImageFirebaseStorage {
    
    private static let storageRootPath = "gs://travller-1617f.appspot.com"
    private static var storageRef = Storage.storage().reference(forURL: storageRootPath)
    
    static func storeImage(image: UIImage, name: String, onComplete: @escaping (String?) -> Void) {
        let path = storageRef.child(name)
        if let data = UIImageJPEGRepresentation(image, 0.8) {
            path.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    Logger.log(message: "Error storing image on firebase storage \(String(describing: error?.localizedDescription))", event: .e)
                    onComplete(nil)
                } else {
                    let downloadUrl = metadata!.downloadURL()
                    onComplete(downloadUrl?.absoluteString)
                }
            }
        }
    }
    
    static func loadImage(url: String, onComplete: @escaping (UIImage?) -> Void) {
        let ref = Storage.storage().reference(forURL: url)
        ref.getData(maxSize: 10000000, completion: { (data, error) in
            if error == nil && data != nil {
                let image = UIImage(data: data!)
                onComplete(image)
            } else {
                Logger.log(message: "Error loading image from firebase \(String(describing: error?.localizedDescription))", event: .e)
                onComplete(nil)
            }
        })
    }
}
