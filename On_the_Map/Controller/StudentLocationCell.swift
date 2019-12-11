//
//  StudentLocationCell.swift
//  On_the_Map
//
//  Created by Hajar F on 11/9/19.
//  Copyright © 2019 Hajar F. All rights reserved.
//

import UIKit


// Mark: - Student Location Cell
class StudentLocationCell: UITableViewCell {

  // Mark:  IBOutlet
    @IBOutlet weak var mapPin: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var mediaURL: UILabel!
    
    
   func configureStudentLocationCell(studentLocation: StudentLocation ){
    mapPin.image = #imageLiteral(resourceName: "pin")
    fullName.text =  "\(studentLocation.firstName ?? "") \(studentLocation.lastName ?? "")"
    mediaURL.text = studentLocation.mediaURL
    }
    
}
