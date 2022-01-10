//
//  ImageSaver.swift
//  BJImagePreview
//
//  Created by Sovannra on 10/1/22.
//

import Foundation

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        let viewController = UIApplication.shared.keyWindow!.rootViewController!
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            viewController.dismiss(animated: true, completion: nil)
        }
        
        let save = UIAlertAction(title: "Save Photo", style: .default) { _ in
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.saveCompleted), nil)
        }
        ac.addAction(cancel)
        ac.addAction(save)
        viewController.present(ac, animated: true)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if (error != nil) {
            // we got back an error!
            Toast.showNegativeMessage(message: "Photo saved fail")
        } else {
            Toast.showPositiveMessage(message: "Photo saved")
        }
    }
}

