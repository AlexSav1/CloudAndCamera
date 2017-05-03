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
    
    weak var reloadDelegate: ReloadDelegate?
    
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
        let uidString = uniqueString.uuidString
        
        let sampleRef = storageRef.child("images/\(uniqueString)")
        
        sampleRef.put(imageData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            let downloadURL = metadata.downloadURL
            
            if let url = downloadURL(){
                // create photo object instance with download url
                let newPhoto = Photo(url: url, UID: uidString)
                newPhoto.comments = ["yup"]
                newPhoto.likes = 0
                self.photos.append(newPhoto)
                //write photo to database using alamofire
                self.writeToDataBase(photoObject: newPhoto)
            }
            
        }
        
    }
    
    
    func writeToDataBase(photoObject: Photo){
        
        //gotta add the sample.jpg or whatever at the end
        let myURL = URL(string: "https://cloudandcamera.firebaseio.com/images.json")
        
        
        let urlString: String = photoObject.downloadURL.absoluteString
        //let UIDString: String = photoObject.UID.uuidString
        
        let params = ["url":urlString, "comments": photoObject.comments!, "likes": photoObject.likes!, "UUID": photoObject.UID] as [String : Any]
        
        Alamofire.request(myURL!, method: .post, parameters: params, encoding:JSONEncoding.default, headers: nil).responseJSON { (response :DataResponse<Any>) in
            
            //response.error
            print(response)
            
            if let JSON = response.result.value{
                //print("JSON: \(JSON)")
                
                if let result = JSON as? [String: Any]{
                    photoObject.name = result["name"] as! String?
                    self.reloadDelegate?.reloadCollectionView()
                }
            }
            
            
        }
        
    }
    
    func createPhotosFromDB() {
        
        let url = URL(string: "https://cloudandcamera.firebaseio.com/images.json")
        
        
        
        Alamofire.request(url!, method: .get, parameters: nil, encoding:JSONEncoding.default, headers: nil).responseJSON { (response :DataResponse<Any>) in
            

                if let JSON = response.result.value{
                    //print("JSON: \(JSON)")
                    
                    if let result = JSON as? [String: Any]{
                        
                    
                    
                    for photo in result{
                        
                        
                        if let photoDict = photo.value as? [String:Any] {
                            if let comments = photoDict["comments"] as? [String], let likes = photoDict["likes"] as? Int, let url = photoDict["url"] as? String, let uid = photoDict["UUID"] as? String {
                                
                                print("comments: \(comments)")
                                print("likes: \(likes)")
                                print("url: \(url)")
                                
                                let theUrl = URL(string: url)
                                
                                let newPhoto = Photo(url: theUrl!, UID: uid)
                                newPhoto.likes = likes
                                newPhoto.comments = comments
                                newPhoto.name = photo.key
                                self.photos.append(newPhoto)
                                
                            }
                        }
                    }
                }
            }
        }
  
        
    }
    
    
    func patchToDataBase(photoObject: Photo){
        
//        var escapedAddress = address.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        let urlString = "https://cloudandcamera.firebaseio.com/images/\(photoObject.name!).json"
        guard let urlSafeString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let myURL = URL(string: urlSafeString)
        
        
        
        let params = ["comments": photoObject.comments!, "likes": photoObject.likes!] as [String : Any]
        Alamofire.request(myURL!, method: .patch, parameters: params, encoding:JSONEncoding.default, headers: nil).responseJSON { (response :DataResponse<Any>) in
            
            //response.error
            print(response)
            
            
        }
        
    }

    
    func deletePhoto(photoObject: Photo){
        
        let sampleRef = storageRef.child("images/\(photoObject.UID)")
        
        // Delete the file
        sampleRef.delete { error in
            if let error = error {
                // Uh-oh, an error occurred!
                print(error)
            } else {
                // File deleted successfully
                print("photo deleted successfully")
                self.deleteMetaData(photoObject: photoObject)
            }
        }
        
        
    }

    func deleteMetaData(photoObject: Photo){
        
        
        let urlString = "https://cloudandcamera.firebaseio.com/images/\(photoObject.name!).json"
        
        guard let urlSafeString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let myURL = URL(string: urlSafeString)
        
        
        Alamofire.request(myURL!, method: .delete, parameters: nil, encoding:JSONEncoding.default, headers: nil).responseJSON { (response :DataResponse<Any>) in
            
            print(response)
            
        }
        
    }


}


