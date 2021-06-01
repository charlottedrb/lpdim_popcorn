//
//  CategoriesViewController.swift
//  PopCorn
//
//  Created by Charlotte Der Baghdassarian on 27/04/2021.
//

import UIKit

private let reuseIdentifier = CategoryCell.reuseId

private let sectionInsets = UIEdgeInsets(
  top: 50.0,
  left: 5.0,
  bottom: 50.0,
  right: 5.0)

class CategoriesViewController: UICollectionViewController {
    
    private let itemsPerRow: CGFloat = 2
    
    //init
    private var categories: Categories = Categories(genres: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(CategoryCell.nib(), forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        //layout.itemSize = CGSize(width: 120, height: 120)
        collectionView.collectionViewLayout = layout
        // Do any additional setup after loading the view.
        
        // Configure variable - Fetch categories
        ApiConnection().getCategories { (categories) in
            self.categories = categories
            
            // Reload view after fetch data
            self.collectionView.reloadData()
            
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categories.genres.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCell
    
        // Configure the cell
        cell.configure(with: categories.genres[indexPath.row].name)
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller : MoviesViewController = MoviesViewController()
        controller.categoryId = categories.genres[indexPath.row].id
        show(controller, sender: self)
        print("Tapped !")
    }
}

// MARK: UICollectionViewDelegateFlowLayout

// Rajoute un comportement sans faire d'héritage
extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 120, height: 120)
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}
