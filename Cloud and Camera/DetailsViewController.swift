//
//  DetailsViewController.swift
//  Cloud and Camera
//
//  Created by Alex Laptop on 3/21/17.
//
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    
    var selectedPhoto: Photo! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.textField.delegate = self
        
        self.navigationItem.title = "Photo Detail"
        self.tabBarController?.tabBar.isTranslucent = false

        self.likesLabel.text = "\(self.selectedPhoto.likes!) Likes"
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }


    override func viewWillAppear(_ animated: Bool) {
        self.imageView.image = self.selectedPhoto.actualImage
        self.tableView.reloadData()
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        
    }
    
    // MARK: - Text field Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(self.textField.text != ""){
            
            let newComment = self.textField.text
            
            self.selectedPhoto.comments?.append(newComment!)
            
            self.tableView.reloadData()
            
            self.textField.text = ""
        }
        
        
        self.textField.resignFirstResponder()
        
        return true
    }
    
    // MARK: - Keyboard methods
    func keyboardWillShow(notification: Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.textField.frame.origin.y -= keyboardSize.height - (self.tabBarController?.tabBar.frame.size.height)!
        }
        
    }
    
    func keyboardWillHide(notification: Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.textField.frame.origin.y += keyboardSize.height - (self.tabBarController?.tabBar.frame.size.height)!
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.selectedPhoto.comments!.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            
     
     // Configure the cell...
        cell.textLabel?.text = "Papa Cheeks"
        cell.detailTextLabel?.text = self.selectedPhoto.comments?[indexPath.row]
     
        return cell
     }

    
// MARK:
// MARK: UITextFieldDelegate Extension

//extension DetailsViewController : UITextFieldDelegate {
//    
//    
//}

    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */


}
