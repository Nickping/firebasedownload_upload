//
//  ViewController.swift
//  musicapi
//
//  Created by Euijoon Jung on 2018. 8. 8..
//

import UIKit
import FirebaseStorage
import FirebaseUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //firebaseUload()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func firebaseUload(){
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        
        // Create a child reference
        // imagesRef now points to "images"
        let imagesRef = storageRef.child("images")
        
        
        // File located on disk
        let localFile = URL(fileURLWithPath: "/Users/euijoonjung/Desktop/main/ios/musicapi/musicapi/Assets.xcassets/happy.imageset/happy.pdf")
        
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("images/happy.pdf")
        
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putFile(from: localFile, metadata: nil) { metadata, error in
            
            if error != nil {
                print("error occcured")
                print(error)
            }else{
                print("file uploaded successfuly")
            }
            
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            // You can also access to download URL after upload.
            riversRef.downloadURL { (url, error) in
                
                if error != nil {
                    print("error occured")
                    print(error)
                }else{
                    print("download url : \(url)")
                }
                
            }
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage"{
            let nextVc = segue.destination as! DownloadViewController
            
        }
    }
    
    @IBAction func downLoadImage(_ sender: UIButton) {
//            performSegue(withIdentifier: "showImage", sender: self)
    }
    
    @IBAction func uploadImageButton(_ sender: UIButton) {
        let storage = Storage.storage()
        let uploadRef = storage.reference().child("images/user/image.jpeg")
        let alertController = UIAlertController(title: "Message", message: "", preferredStyle: .alert)
        
        if let imageData = UIImageJPEGRepresentation(imageView.image!, 1) {
            uploadRef.putData(imageData, metadata: nil) { (action, error) in
                if error != nil {
                    print("file uploading error")
                    print(error)
                    let alert = UIAlertAction(title: "upload error", style: .default, handler: nil)
                    alertController.addAction(alert)
                    self.present(alertController, animated: true, completion: nil)
                }else {
                
                    let alert = UIAlertAction(title: "upload finished ", style: .default, handler: nil)
                    alertController.addAction(alert)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
        }else {
         let alert = UIAlertAction(title: "file convert error", style: .default, handler: nil)
            alertController.addAction(alert)
            self.present(alertController, animated: true, completion: nil)
        }
        //
        //        var imageData: Data = UIImagePNGRepresentation(image)
        //        var imageUIImage: UIImage = UIImage(data: imageData)
        
    }
    @IBAction func findImageButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "find image", message: "", preferredStyle: .actionSheet)
        let alert = UIAlertAction(title: "find image from library", style: .default, handler: {(action) in 
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil) }
        })
        alertController.addAction(alert)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    //    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    //        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
    //            restaurantImage.image = selectedImage
    //            restaurantImage.contentMode = .scaleAspectFill
    //            restaurantImage.clipsToBounds = true
    //        }
    //    }
    
}

