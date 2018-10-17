//
//  ItemCell.swift
//  Weekly
//
//  Created by Zachary Williams on 8/3/18.
//  Copyright © 2018 Zachary Williams. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell
{
    // labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var expirationLabel: UILabel!
    
    // credit slots
    @IBOutlet weak var creditSlot1ImageView: UIImageView!
    @IBOutlet weak var creditSlot2ImageView: UIImageView!
    @IBOutlet weak var creditSlot3ImageView: UIImageView!
    @IBOutlet weak var creditSlot4ImageView: UIImageView!
    @IBOutlet weak var creditSlot5ImageView: UIImageView!
    @IBOutlet weak var creditSlot6ImageView: UIImageView!
}
