//
//  ProfileViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 13.11.2024.
//

import UIKit
import SnapKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    let viewModel: ProfileViewModel = ProfileViewModel()

    // Profile Image View
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus.circle")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // Name Label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone: "
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    // Name Value Label
    private let nameValueLabel: UILabel = {
        let label = UILabel()
        label.text = "User's Name"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // Email Label
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email: "
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    // Email Value Label
    private let emailValueLabel: UILabel = {
        let label = UILabel()
        label.text = "user@example.com"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // Log Out Button
    private let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        return button
    }()
    
    // Delete Account Label
    private let deleteAccountLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Delete Account")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: attributedString.length))
        
        label.attributedText = attributedString
        label.font = .systemFont(ofSize: 16)
        label.isUserInteractionEnabled = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        prepareView()
    }

    private func setupViews() {
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(nameValueLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailValueLabel)
        view.addSubview(deleteAccountLabel) // Add delete account label
        view.addSubview(logOutButton)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(120)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        nameValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(10)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        emailValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(emailLabel)
            make.left.equalTo(emailLabel.snp.right).offset(10)
        }

        deleteAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(emailValueLabel.snp.bottom).offset(44) // Positioned below email value label
            make.centerX.equalToSuperview()
        }
        
        deleteAccountLabel.alpha = 0.6
        logOutButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }

    private func prepareView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageVİewTapped))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGesture)
        
        let deleteTapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteAccountTapped)) // Add tap gesture for delete account
        deleteAccountLabel.addGestureRecognizer(deleteTapGesture)
        
        profileImageView.layer.cornerRadius = 60
        profileImageView.layer.masksToBounds = true
        
        loadImageToImageView()
        
        viewModel.fetchUserPhoneNumber(user: Auth.auth().currentUser!) { phoneNumber in
            if let phoneNumber = phoneNumber {
                self.nameValueLabel.text = phoneNumber
            } else {
                self.nameValueLabel.isHidden = true
            }
        }
        
        let userEmail = Auth.auth().currentUser?.email ?? "Email"
        self.emailValueLabel.text = userEmail
    }

    @objc private func logOutTapped() {
        do {
            try Auth.auth().signOut()
            
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.switchToSignIn()
            }
            
            print("Logged out successfully")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    @objc func imageVİewTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func loadImageToImageView() {
        viewModel.fetchImageURLFromFirestore { imageURL in
            guard let imageURL = imageURL else {
                return
            }
            
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.profileImageView.image = image
                    }
                } else {
                    print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        }
    }
    
    @objc private func deleteAccountTapped() {
        // Giriş yapmış kullanıcıyı al
         guard let user = Auth.auth().currentUser else {
             print("No user is logged in.")
             return
         }
         
         // Kullanıcıyı silme işlemi
         user.delete { error in
             if let error = error {
                 print("Error deleting user: \(error.localizedDescription)")
             } else {
                 MessageManager.shared.show(message: "User account successfully deleted.", type: .success)
                 
                 if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                     sceneDelegate.switchToSignIn()
                 }
             }
         }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
            viewModel.uploadImageToFirebase(selectedImage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
