//
//  ProfileViewModel.swift
//  AccountChain
//
//  Created by Emre Öztürk on 13.11.2024.
//
import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore


class ProfileViewModel {
   
    func uploadImageToFirebase(_ image: UIImage) {
       guard let imageData = image.jpegData(compressionQuality: 0.5) else {
           print("Error: Could not convert image to data")
           return
       }
       
       let userId = Auth.auth().currentUser?.uid ?? UUID().uuidString
       let storageRef = Storage.storage().reference().child("profile_images/\(userId).jpg")
       
       storageRef.putData(imageData, metadata: nil) { metadata, error in
           if let error = error {
               print("Error uploading image: \(error.localizedDescription)")
               return
           }
           
           storageRef.downloadURL { url, error in
               if let error = error {
                   print("Error getting download URL: \(error.localizedDescription)")
                   return
               }
               
               if let downloadURL = url {
                   print("Image uploaded successfully: \(downloadURL.absoluteString)")
                   self.saveImageURLToFirestore(downloadURL)
               }
           }
       }
   }
    
    
    func saveImageURLToFirestore(_ url: URL) {
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser?.uid ?? UUID().uuidString
        
        db.collection("users").document(userId).setData(["profileImageURL": url.absoluteString], merge: true) { error in
            if let error = error {
                MessageManager.shared.show(message: "\(error.localizedDescription)", type: .error)

            } else {
                MessageManager.shared.show(message: "Image saved successfully", type: .success)
            }
        }
    }
    
    func fetchImageURLFromFirestore(completion: @escaping (URL?) -> Void) {
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser?.uid ?? UUID().uuidString
        
        db.collection("users").document(userId).getDocument { document, error in
            if let error = error {
                print("Error fetching image URL from Firestore: \(error.localizedDescription)")
                completion(nil)
            } else {
                if let document = document, document.exists {
                    if let imageURLString = document.data()?["profileImageURL"] as? String,
                       let imageURL = URL(string: imageURLString) {
                        completion(imageURL)
                    } else {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func fetchUserPhoneNumber(user: User, completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)
        
        userRef.getDocument { (document, error) in
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                completion(nil)
            } else if let document = document, document.exists {
                let phoneNumber = document.get("phoneNumber") as? String
                completion(phoneNumber)
            } else {
                completion(nil)
            }
        }
    }
}
