//
//  SecondViewController.swift
//  Cloud and Camera
//
//  Created by Aditya Narayan on 3/15/17.
//
//

import UIKit

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Photo Library"
    }

    @IBAction func takePhotoPressed(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true, completion: nil)
        
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
            
//            picker.dismiss(animated: true, completion: {
//                self.createPresentItem(with: image)
//            })
            
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

