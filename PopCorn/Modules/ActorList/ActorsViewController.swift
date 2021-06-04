//
//  ActorsViewController.swift
//  PopCorn
//
//  Created by Charlotte Der Baghdassarian on 04/06/2021.
//

import UIKit

private let reuseIdentifier = ActorCell().reuseId

private let sectionInsets = UIEdgeInsets(
  top: 50.0,
  left: 5.0,
  bottom: 50.0,
  right: 5.0)

class ActorsViewController: UICollectionViewController {
    
    private let itemsPerRow: CGFloat = 2
    
    private var topActors: TopActors = TopActors(page: 1, results: [], totalResults: 1, totalPages: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        
        collectionView.collectionViewLayout = layout

        // Register cell classes
        self.collectionView!.register(ActorCell().nib(), forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        // Configure the cell
        ApiConnection().getTopActors { (topActors) in
            self.topActors = topActors
            
            self.collectionView.reloadData()
        }
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
        return topActors.results.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ActorCell
        
        let actor = topActors.results[indexPath.row]
        
        cell.actorName.text = actor.name
        
        if let profilePath = actor.profilePath, let path = URL(string: "https://image.tmdb.org/t/p/w500/\(profilePath)") {
            cell.actorPicture.downloaded(from: path)
        } else {
            print("error with image")
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller: ActorMoviesViewController = ActorMoviesViewController()
        controller.knownFor = topActors.results[indexPath.row].knownFor
        show(controller, sender: self)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

// Add a behaviour without doing heritage
// Here, we're calculating cell size in a way they could expand the most
extension ActorsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}
