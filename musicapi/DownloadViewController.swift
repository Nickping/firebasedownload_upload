//
//  DownloadViewController.swift
//  musicapi
//
//  Created by Euijoon Jung on 2018. 8. 8..
//

import UIKit
import FirebaseStorage
import FirebaseUI

class DownloadViewController: UIViewController {
    
    
    @IBOutlet weak var downloadImageView: UIImageView!
    var downloadImageString : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //downloadImageView.image = UIImage(named: downloadImageString)
        // Do any additional setup after loading the view.
        let storage = Storage.storage()
        let downloadRef = storage.reference().child("images/user/image.jpeg")
        
        downloadRef.downloadURL { (url, error) in
            
            if error != nil {
                print("error occured")
                print(error)
            }else{
                print("download url : \(url)")
                do
                {
                    let data = try Data(contentsOf: url!)
                    let image = UIImage(data: data as Data)
                    self.downloadImageView.image = image
                }
                catch{}
                
                
            }
            
        }
       // downloadImageView.sd_setImage(with: downloadRef)
        //
        //        let imageStorageRef = Storage.storage().reference(forURL: imageDownloadURL)
        //        imageStorageRef.getData(maxSize: 2 * 1024 * 1024) { [weak self] (data, error) in
        //            if let error = error {
        //                print("******** \(error)")
        //            } else {
        //                if let imageData = data {
        //                    let image = UIImage(data: imageData)
        //                    DispatchQueue.main.async {
        //                        self?.postImageView.image = image
        //                    }
        //                }
        //            }
        //        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
