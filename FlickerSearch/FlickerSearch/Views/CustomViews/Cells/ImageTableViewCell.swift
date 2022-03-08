//
//  ImageTableViewCell.swift
//  FlickerSearch
//
//  Created by kdodla on 3/7/22.
//

import UIKit
import Kingfisher

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet var serchImageView: UIImageView!
    @IBOutlet var searchImageTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with item: Items) {
        if let title = item.title, title.count > 1 {
            self.searchImageTitleLabel?.text = title
        } else {
            self.searchImageTitleLabel?.text = ConstantStrings.placeholderTitle.uppercased()
        }
        if let urlString = item.media?.mediaLink, let url = URL(string: urlString) {
            self.serchImageView.kf.setImage(with: url, placeholder: UIImage(named: ImageName.placeholderCvsImage), options: nil, completionHandler: nil)
        } else {
            self.serchImageView.image = UIImage(named: ImageName.placeholderCvsImage)
        }
    }
}
