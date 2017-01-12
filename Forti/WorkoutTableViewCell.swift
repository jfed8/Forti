//
//  WorkoutTableViewCell.swift
//  Forti
//
//  Created by J J Feddock on 12/17/15.
//  Copyright © 2015 Forti Athletics Inc. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var WorkoutName: UILabel!
    
    @IBOutlet weak var WorkoutDistance: UILabel!
    
    @IBOutlet weak var WorkoutDate: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
