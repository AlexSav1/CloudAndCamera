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
    var likes : Int?
    var actualImage: UIImage?
    
    init(url: URL) {
        //self.name = imageName
        self.downloadURL = url
        //self.comments = [Any]()
        //self.likes = like
    }
    
}
