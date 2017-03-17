//
//  DAO.swift
//  Cloud and Camera
//
//  Created by Aditya Narayan on 3/16/17.
//
//

import Foundation
import FirebaseStorage
import Alamofire

class DAO {
    
    static let sharedInstance = DAO()
    
    
//    let storage = FIRStorage.storage()
//    
//    // Create a storage reference from our storage service
//    let storageRef = storage.reference()
    
    let storage : FIRStorage
    let storageRef : FIRStorageReference
    let imagesReference : FIRStorageReference
    var photos = [Photo]()
    
    private init() {
        
        self.storage = FIRStorage.storage()
        self.storageRef = self.storage.reference()
        self.imagesReference = self.storageRef.child("images")
        
    }
    
    
    
    func putImageInStorage(nameOfFile : String, imageData : Data){
        
        let uniqueString = UUID.init()
        print(uniqueString)
        let sampleRef = storageRef.child("images/\(uniqueString).jpg")
        
        sampleRef.put(imageData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            let downloadURL = metadata.downloadURL
            
            if let url = downloadURL(){
                // create photo object instance with download url
                let newPhoto = Photo(url: url)
                newPhoto.comments = []
                newPhoto.likes = 0
                self.photos.append(newPhoto)
                //write photo to database using alamofire
                self.writeToDataBase(photoObject: newPhoto)
            }
            
        }
        
    }
    
    
    func writeToDataBase(photoObject: Photo){
        
        //gotta add the sample.jpg or whatever at the end
        let myURL = URL(fileURLWithPath: "https://cloudandcamera.firebaseio.com/images/")
        
        
        let params = ["url":photoObject.downloadURL, "comments": photoObject.comments!, "likes": photoObject.likes!] as [String : Any]
        Alamofire.request(myURL, method: .put, parameters: params, encoding:JSONEncoding.default, headers: nil).responseJSON { (response :DataResponse<Any>) in
            
            //response.error
        
            
        }
        
    }

    
    
}
