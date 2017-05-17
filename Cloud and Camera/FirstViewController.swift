//
//  FirstViewController.swift
//  Cloud and Camera
//
//  Created by Aditya Narayan on 3/15/17.
//
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collectionView: UICollectionView!

    let detailsVC: DetailsViewController = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
    
    let dao = DAO.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.dao.reloadDelegate = self
        self.navigationItem.title = "Photo Library"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        //self.detailsVC = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        
        // Register cell classes
        //self.collectionView!.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.dao.createPhotosFromDB()
        print("Count: \(self.dao.photos.count)")
        self.collectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dao.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        
        let currentPhoto: Photo = self.dao.photos[indexPath.row]
        
        // Configure the cell
        //downloading the image is making it take forever
        
            if(currentPhoto.actualImage == nil){
                
                DispatchQueue.global().async {
                let data = try? Data(contentsOf: currentPhoto.downloadURL)
                    
                    DispatchQueue.main.async {
                        cell.imageView.image = UIImage(data: data!)
                        currentPhoto.actualImage = UIImage(data: data!)
                    }
                    
                }
            } else {
                cell.imageView.image = currentPhoto.actualImage
            }


        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedPhoto: Photo = self.dao.photos[indexPath.row]
    
        self.detailsVC.selectedPhoto = selectedPhoto
        self.navigationController?.pushViewController(self.detailsVC, animated: true)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    

}



extension FirstViewController: ReloadDelegate {
    
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
}
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 160, height: 160)
//    }
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    


