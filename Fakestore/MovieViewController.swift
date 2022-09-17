//
//  MovieViewController.swift
//  Fakestore
//
//  Created by Apple on 14/09/22.
//

import UIKit

private let reuseIdentifier = "movieCell"

class Movie: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
}

class Header: UICollectionReusableView{
    @IBOutlet weak var sectionTitle: UILabel!
}

class MovieViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let moviesList : [UIImage] = [
        UIImage(named: "avengers")!,
        UIImage(named: "moonknight")!,
        UIImage(named: "antman")!,
        UIImage(named: "doctorstrange")!,
        UIImage(named: "blackwidow")!,
    ]
    
    let sonyMoviesList : [UIImage] = [
        UIImage(named: "spider1")!,
        UIImage(named: "spider2")!,
        UIImage(named: "spider3")!,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "Movie", bundle: Bundle(identifier: "tt.Fakestore"))
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        let header = UINib(nibName: "Header", bundle: Bundle(identifier: "tt.Fakestore"))
        collectionView.register(header, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        
    }

}

extension MovieViewController :UICollectionViewDataSource{
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 2
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            if(section == 0){
                return moviesList.count
            }else{
                return sonyMoviesList.count
            }
            
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? Movie else {
                return UICollectionViewCell()
            }
            
            if(indexPath.section == 0){
                cell.movieImage.image = moviesList[indexPath.row]
            }else{
                cell.movieImage.image = sonyMoviesList[indexPath.row]
            }
            

            return cell
        }
}
      
      
extension MovieViewController :UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MovieDetails") as! MovieDetailsViewController
        
        if(indexPath.section == 0){
            vc.image = moviesList[indexPath.row]
        }else{
            vc.image = sonyMoviesList[indexPath.row]
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MovieViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath)
                as? Header else {
            return UICollectionReusableView()
        }
        
        if(indexPath.section == 0){
            header.sectionTitle.text = "Marvel"
        }else{
            header.sectionTitle.text = "Sony"
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height:70)
    }
}
