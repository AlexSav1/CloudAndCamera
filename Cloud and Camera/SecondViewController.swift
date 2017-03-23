//
//  SecondViewController.swift
//  Cloud and Camera
//
//  Created by Aditya Narayan on 3/15/17.
//
//

import UIKit
import FirebaseStorage

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let dao = DAO.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.dao.createPhotosFromDB()
    }

    @IBAction func takePhotoPressed(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        
        //if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum)
        
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)

            
        } else{
            
            //show alerts
            let noCameraAlert = UIAlertController(title: "Error", message: "No camera available", preferredStyle: .alert)
            
            noCameraAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(noCameraAlert, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func selectPhotoPressed(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true){}
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            picker.dismiss(animated: true, completion: {
                
                let imageData = UIImageJPEGRepresentation(image, 1.0)
                self.dao.putImageInStorage(nameOfFile: "sample", imageData: imageData!)
            })
            
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

