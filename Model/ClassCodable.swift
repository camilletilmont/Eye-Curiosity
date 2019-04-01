//
//  ClassCodable.swift
//  CuriosityEye
//
//  Created by Camille Tilmont on 28/10/2017.
//  Copyright © 2017 Camille Tilmont. All rights reserved.
//

import Foundation

class PhotoSeries : Codable {
    var photos: [Course] = []
    
    init(photos : [Course]){
        self.photos = photos
        
    }
}

class Course : Codable {
    var id : Int
    var sol : Int
    var img_src : String = ""
    var earth_date : String
    
    init(id: Int, sol : Int, img_src : String, earth_date : String){
        self.id = id
        self.sol = sol
        self.img_src = img_src
        self.earth_date = earth_date
        
        
    }
    
    
}
