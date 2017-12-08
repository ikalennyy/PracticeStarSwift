//
//  Medals.swift
//  FinalProject_Start_WithTests
//
//  Created by Igor Kalennyy on 11/29/17.
//  Copyright © 2017 A290/A590 Fall 2017 - ikalenny. All rights reserved.
//

import Foundation
import UIKit

class Medals: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var Medals: Array<Medal>!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Medals.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //register cell somewhere!!!
        let identifier = "MedalCollectionViewCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MedalCollectionViewCell
        
        return cell
        
    }

    
    func setupControL(medals: Array<Medal>,settings: Settings){
        //self.reloadSections(IndexSet(integer: 0))
    }
    
    override func awakeFromNib() {
      //  self.dataSource = Medals
      //  self.delegate = self
        
        self.register(MedalCollectionViewCell.self, forCellWithReuseIdentifier: "MedalCollectionViewCell")
    }
    
}
