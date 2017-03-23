//
//  Photo.swift
//  Cloud and Camera
//
//  Created by Aditya Narayan on 3/16/17.
//
//

import UIKit

class Photo: NSObject {

    var name: String?
    var comments : [String]?
    let downloadURL: URL
    let UID: String
    var likes : Int?
    var actualImage: UIImage?
    
    init(url: URL, UID: String) {
        
        self.downloadURL = url
        self.UID = UID
        
    }
    
}
