//
//  MedalsViewController.swift
// Practice Star
// Igor Kalennyy
// "A590 / Spring 2017"
// December 15, 2017

import UIKit

class MedalsViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource  {

    var Medals: Array<Medal>!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Medals = appDelegate.appmodel?.getAllStudents().first?.getAllAwards().medals
        
        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Medals.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //register cell somewhere!!!
        let identifier = "MedalCollectionViewCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MedalCollectionViewCell
        
        return cell
    }
    

    /*
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath) as! CollectionViewHeader
        
        header.setupControl(student: (appDelegate.appmodel?.getAllStudents().first)!, settings: (appDelegate.appmodel?.setting)!)
        
        return header
    }
 */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showAssignment"?:
            if let selectedIndexPath =
                collectionView.indexPathsForSelectedItems?.first {
                
                let medal = Medals[selectedIndexPath.row]
                
                let destinationVC =
                    segue.destination as! TasksViewValidateController
                destinationVC.theAssignment = medal.AwardedFor()
                destinationVC.theSettings = appDelegate.appmodel?.setting

            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }



}
