//
//  MapAnnotationHolder.swift
//  Traveller
//
//  Created by Tal Sahar on 27/04/2018.
//  Copyright © 2018 Traveller52. All rights reserved.
//

import Foundation
import MapKit
class AnnotationHolder {
    
    var members = [String: MKPointAnnotation]()
    var guiders = [String: MKPointAnnotation]()
    var path: [Position]?
    
    init(path: [Position]) {
        self.path = path
    }
    
    // adding and returns the old annotating
    func addMember(type: UserType, uid: String, annotation: MKPointAnnotation) -> MKPointAnnotation? {
        
        if type == .traveler {
            let previewAnnotation = self.members[uid]
            self.members[uid] = annotation
            return previewAnnotation
        } else if type == .guide {
            let previewAnnotation = self.guiders[uid]
            self.guiders[uid] = annotation
            return previewAnnotation
        }
        return nil
    }
}
