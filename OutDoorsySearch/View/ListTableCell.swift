//
//  ListTableCell.swift
//  OutDoorsySearch
//
//  Created by Sharat on 2/26/21.
//

import UIKit

class ListTableCell: UITableViewCell {
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func updateListCell(_ outDoorsyRespone: OutdoorsyResponse?) {
        if let doorsy = outDoorsyRespone?.data?[self.tag], let obj = doorsy.attributes {
            titleLabel.text = obj.name
        }
        if let doorsy = outDoorsyRespone?.data?[self.tag], let obj = doorsy.relationships {
            guard let imageUrl = outDoorsyRespone?.getImageUrlOftheRental(obj.primaryImage?.data?.id) else { return  }
            ImageDownloader.shared.downloadImage(with: imageUrl, completionHandler: { (image, cached) in

                self.displayImage.image = image

            }, placeholderImage: nil)
        }
    }
}
