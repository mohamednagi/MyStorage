import UIKit
import FirebaseStorage


class ViewController: UIViewController {

    @IBOutlet weak var uploadimage: UIImageView!
    @IBOutlet weak var downloadimage: UIImageView!
    
    let filename = "earth.jpg"
    var imageRef :StorageReference {
        return Storage.storage().reference().child("images")
    }
    
    @IBAction func uploadBu(_ sender: UIButton) {
        guard let image = uploadimage.image else {return}
        guard let imageData = UIImageJPEGRepresentation(image, 1) else {return}
        
        let uploadImageRef = imageRef.child(filename)
        
        let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
            print("upload finished")
            print(metadata ?? "No meta data")
            print(error ?? "no error shown")
        }
//        uploadTask.observe(.progress) { (snapshot) in
//            print(snapshot.progress ?? "no more progress")
//        }
        uploadTask.resume()
    }
    
    @IBAction func downloadBu(_ sender: UIButton) {
        let downloadImageRef = imageRef.child(filename)
        
        let downloadTask = downloadImageRef.getData(maxSize: 1024*1024*12) { (data, error) in
            if let data = data {
                let image = UIImage(data: data)
                self.downloadimage.image = image
            }
            print(error ?? "No error")
        }
//        downloadTask.observe(.progress) { (snapshot) in
//            print(snapshot.progress ?? "no more progress")
//        }
        downloadTask.resume()
    }
    
    
}

