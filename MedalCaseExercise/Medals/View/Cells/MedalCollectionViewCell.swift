//
//  MedalCollectionViewCell.swift
//  MedalCaseExercise
//
//  Created by Raphael Araújo on 2024-11-26.
//

import UIKit

class MedalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var medal: Medal? {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        descriptionLabel.text = nil
        imageView.image = nil
        medal = nil
    }
    
    private func configureCell() {
        guard let medal = medal else {
            titleLabel.text = nil
            descriptionLabel.text = nil
            imageView.image = nil
            return
        }
        
        titleLabel.text = medal.title
        descriptionLabel.text = medal.achievement.value
        imageView.image = UIImage(named: medal.icon)
    }
}
