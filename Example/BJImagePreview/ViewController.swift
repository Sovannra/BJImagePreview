//
//  ViewController.swift
//  BJImagePreview
//
//  Created by Sovannra on 01/05/2022.
//  Copyright (c) 2022 Sovannra. All rights reserved.
//

import UIKit
import BJCollection
import BJImagePreview

class ViewController: UIViewController {

    var imageArr: [String] = ["https://static.vecteezy.com/packs/media/components/global/search-explore-nav/img/vectors/term-bg-1-666de2d941529c25aa511dc18d727160.jpg", "https://tinypng.com/images/social/website.jpg", "https://upload.wikimedia.org/wikipedia/commons/9/9a/Gull_portrait_ca_usa.jpg", "https://images.unsplash.com/photo-1612151855475-877969f4a6cc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aGQlMjBpbWFnZXxlbnwwfHwwfHw%3D&w=1000&q=80", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlrZqTCInyg6RfYC7Ape20o-EWP1EN_A8fOA&usqp=CAU", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTExtoLVhMIfPRj_8d5RQKF2qjwUbuYL2tZTg&usqp=CAU", "https://i.pinimg.com/originals/ca/76/0b/ca760b70976b52578da88e06973af542.jpg", "https://st.depositphotos.com/1006706/2671/i/600/depositphotos_26715369-stock-photo-which-way-to-choose-3d.jpg", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmdLr50nm6KsHV-Iv_VMlvqGoNRJHb5LpTbA&usqp=CAU", "https://pagalladka.com/wp-content/uploads/2018/12/full-size-HD-image-of-nature-500x375.jpg", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-fff2lftqIE077pFAKU1Mhbcj8YFvBbMvpA&usqp=CAU", "https://content.api.news/v3/images/bin/b06bef9a5f8153a24f4abb07cbc2c11e?width=650", "https://static8.depositphotos.com/1008939/939/i/600/depositphotos_9394698-stock-photo-lonely-man.jpg", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjJTcYFdKdHZCkOxvGGIEEfyF1y9lVQImp6g&usqp=CAU", "https://theinpaint.com/images/example-1-2.jpg", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFwrJ_mJuCXqBSVnsvW8qOwNoF2k3d6mQOJw&usqp=CAU", "https://imgv3.fotor.com/images/homepage-feature-card/Fotor-image-cropper.jpg", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdFgtmuSpT4WmXNL4iw7y9mkyZShhA9UMXKxQj1qOciFWoz776Voow-4Bops2qcS3ZsF8&usqp=CAU", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRisv-yQgXGrto6OxQxX62JyvyQGvRsQQ760g&usqp=CAU", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdwyMFRcoKj1kEEiDpD_S-Vh6rsVxsL3rCxg&usqp=CAU", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_Vwf0jgZzIa3E8BDM3ag4J1SjoyQDLnL1fl28xk-O9NYmzE_3Dmp2uq0YtbrKCLtExDk&usqp=CAU", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzQmuasfK1qjFkjJL-4h21Yps4e3i0fpHBBQ&usqp=CAU", "https://us.123rf.com/450wm/manopphimsit/manopphimsit1709/manopphimsit170900180/87173291-silhouette-image-of-a-businessman-with-broken-chains-in-sunset.jpg?ver=6", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvDbnh2bfELvkgZNlYP5Zp1Iu7IYG02pME6Q&usqp=CAU", "https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg", "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg", "https://www.health.gov.au/sites/default/files/documents/2020/11/coronavirus-covid-19-image---how-s-your-head-today---2.jpg", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXYMefQUYs_g75T96q8Oh99JmICO9u2XMsvQ&usqp=CAU", "https://www.justjamila.com/ezoimgfmt/justjamila.com/wp-content/uploads/2020/11/cute-wallpapers-3.jpg?ezimgfmt=rs:330x585/rscb1/ng:webp/ngcb1", "https://www.u-buy.jp/productimg/?image=aHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0kvNDEtRVVNV2FuRFMuX0FDX1NMMTAwMV8uanBn.jpg"]
    
    var loadIndex: Int {
        return imageArr.count - 10
    }
    var oldIndex: Int = 0
    var isReachLimit: Bool = false
    
    let moreImage: [String] = ["https://imagekit.io/blog/content/images/2019/12/image-optimization.jpg", "https://f.hubspotusercontent00.net/hubfs/53/image-file-extensions.jpg", "https://cdn.searchenginejournal.com/wp-content/uploads/2019/08/c573bf41-6a7c-4927-845c-4ca0260aad6b-1520x800.jpeg", "https://s3.amazonaws.com/images.seroundtable.com/google-css-images-1515761601.jpg", "https://images.pexels.com/photos/1194036/pexels-photo-1194036.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500", "https://images.unsplash.com/photo-1425082661705-1834bfd09dca?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb", "https://cdn.pixabay.com/photo/2018/10/01/09/21/pets-3715733__340.jpg", "https://media.istockphoto.com/photos/adorable-welsh-corgi-pembroke-on-green-lawn-at-home-picture-id1077145200?k=20&m=1077145200&s=612x612&w=0&h=ucf27be8uOUbnP2piSuRCKzXobXSiLAFUfMMNrPTelQ=", "https://static.statusqueen.com/mobilewallpaper/thumbnail/alone-511.jpg", "https://images.pexels.com/photos/1767434/pexels-photo-1767434.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500", "https://wallpaperaccess.com/full/1524043.jpg", "https://www.pixelstalk.net/wp-content/uploads/2016/08/Best-Cute-Backgrounds-For-Desktop.jpg", "https://data.1freewallpapers.com/download/cute-anime-girl-4k-2800x2100.jpg", "https://c4.wallpaperflare.com/wallpaper/40/946/484/animated-cute-desktop-wallpaper-preview.jpg", "https://cdn3.vectorstock.com/i/1000x1000/22/37/cute-love-valentine-couple-doodle-vector-24542237.jpg", "https://i.pinimg.com/474x/82/12/2c/82122c3a877d8c3fb8f832cfb701ece1--hj-stories-love-is-hj-story.jpg", "https://c0.wallpaperflare.com/preview/714/307/764/hand-love-cute-romance.jpg", "https://i0.wp.com/thenerddaily.com/wp-content/uploads/2018/08/Reasons-To-Watch-Anime.jpg?fit=1000%2C742&ssl=1", "https://besthqwallpapers.com/Uploads/17-2-2018/41098/thumb2-zero-two-manga-anime-characters-pink-hair-darling-in-the-franxx.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Photo"
        setupView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        guard let flowLayout = vCollection.collectionViewLayout as? BaseCollectionViewFlowLayout else {
            return
        }
        flowLayout.heightItems = 0
        if UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) {
            //here you can do the logic for the cell size if phone is in landscape
            flowLayout.numberOfItemsInRow = 5
        } else {
            //logic if not landscape
            flowLayout.numberOfItemsInRow = 3
        }
        flowLayout.invalidateLayout()
    }
    
    func setupView() {
        view.addSubview(vCollection)
        vCollection.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        vCollection.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        vCollection.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        vCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    lazy var vCollection: BJCollectionView = {
        let view = BJCollectionView(numberOfItems: 3, spacingBetweenItems: 1.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showScrollIndicator = false
        view.alwaysBounceVertical = true
        view.register(cell: ImageCell.self)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var vImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCell = collectionView.dequeue(for: indexPath)
        cell.imageString = imageArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = vCollection.cellForItem(at: indexPath) as! ImageCell
        vImage = cell.vImage
        oldIndex = indexPath.row
        let statusImageView = vImage
        statusImageView.alpha = 0
        
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            let viewController = UIApplication.shared.keyWindow!.rootViewController!
            viewController.popImageViewer(
                photos: imageArr,
                outsideFrame: startingFrame,
                statusImageView: statusImageView,
                currentIndex: indexPath.row,
                imageViewerDelegate: self
            )
        }
    }
}

extension ViewController: ImageViewerDelegate{

    public func imageViewer(imageViewerView: ImageViewerView, getCurrentIndex index: Int) {
        appendImage(imageViewerView: imageViewerView, index: index)
        if oldIndex != index {
            updateImageView(imageViewerView: imageViewerView, index: oldIndex, alpha: 1)
        }
        updateImageView(imageViewerView: imageViewerView, index: index, alpha: 0)
        oldIndex = index
        vCollection.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredVertically, animated: false)
    }

    public func imageViewer(imageViewerView: ImageViewerView, graggingView state: ImageViewerView.DraggingState) {
        switch state {
        case .ended:
            let statusImageView = vImage
            statusImageView.alpha = 1
        default:
            break
        }
    }
    
    private func updateImageView(imageViewerView: ImageViewerView, index: Int, alpha: CGFloat) {
        let indexPath = IndexPath(item: index, section: 0)
        guard let cell = vCollection.cellForItem(at: indexPath) as? ImageCell else { return }
        vImage = cell.vImage
        oldIndex = index
        let statusImageView = vImage
        statusImageView.alpha = alpha
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            let viewController = UIApplication.shared.keyWindow!.rootViewController!
            viewController.updateImageViewer(
                imageViewerView: imageViewerView,
                outsideFrame: startingFrame,
                statusImageView: statusImageView
            )
        }
    }
}

extension ViewController {
    
    func appendImage(imageViewerView: ImageViewerView, index: Int) {
        let not = (!)
        if not(isReachLimit) && index >= loadIndex {
            isReachLimit = true
            imageArr.append(contentsOf: moreImage)
            vCollection.reloadData()
            let viewController = UIApplication.shared.keyWindow!.rootViewController!
            viewController.loadMoreImageViewer(imageViewerView: imageViewerView, photo: moreImage, currentIndex: index)
        }
    }
}
