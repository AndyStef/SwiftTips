extension UIImagePickerController {
    static func obtainPermission(for sourceType: UIImagePickerControllerSourceType, successHandler: (()->())?, failureHandler: (()->())?) {

        if sourceType == .photoLibrary || sourceType == .savedPhotosAlbum {
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch (status) {
                case .authorized:
                    DispatchQueue.main.async {
                        successHandler?()
                    }
                case .restricted, .denied:
                    DispatchQueue.main.async {
                        failureHandler?()
                    }
                default: break
                }
            })
        }
        else if sourceType == .camera {
            let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
            switch (status) {
            case .authorized:
                DispatchQueue.main.async {
                    successHandler?()
                }
            case .notDetermined:
                AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted) in
                    if granted {
                        DispatchQueue.main.async {
                            successHandler?()
                        }
                    } else {
                        DispatchQueue.main.async {
                            failureHandler?()
                        }
                    }
                })
            case .denied, .restricted:
                DispatchQueue.main.async {
                    failureHandler?()
                }
            }
        }
        else {
            assert(false, "Permission type not found")
        }
    }
}





//In case of failure we can suggest user to go to settings 
if let url = URL(string: UIApplicationOpenSettingsURLString) {
    UIApplication.shared.openURL(url)
}
