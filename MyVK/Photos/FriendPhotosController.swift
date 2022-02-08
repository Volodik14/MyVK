//
//  FriendPhotosController.swift
//  MyVK
//
//  Created by Владимир Моторкин on 01.02.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendPhotosController: UICollectionViewController {
    
    var userPhotos = [Photo]()
    var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            let vkService = VKService(userId, accessToken)
            vkService.loadUserProfilePhotos(userId: userId, completion: {photos in
                //print("photos \(photos)")
                self.userPhotos = photos
                self.collectionView.reloadData()
            })
        } else {
            print("Cannot get data, cannot get access token!")
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        print(userPhotos.count)
        return userPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendPhotosCell", for: indexPath) as! FriendPhotosCell
        
        let photo = userPhotos[indexPath.row]
        
        cell.friendPhoto.image = nil
        let url = URL(string: photo.url)!
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    var image = UIImage(data: data)
                    //image = image?.scalePreservingAspectRatio(targetSize: CGSize(width: 26, height: 26))
                    //cell.friendPhoto.clipsToBounds = true
                    cell.friendPhoto.image = image
                    //self.tableView.reloadRows(at: [indexPath], with: .none)
                    //TODO: Починить отображение
                }
            } else {
                cell.friendPhoto.image = UIImage(systemName: "circle")
            }
        }
        
        
        return cell
    }
    
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
    
}
