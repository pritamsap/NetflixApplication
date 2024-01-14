//
//  HeroHeaderUIView.swift
//  NetflixApplication
//
//  Created by pritam on 2024-01-11.
//

import UIKit

class HeroHeaderUIView: UIView {

    // button implementation for Play and Download
    private let playButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        
        // To allow constraints to be used
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        
        // To allow constraints to be used
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let heroImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
    }
    
    
    // Implementation of constraints for the button
    private func applyConstraints(){
        
        let playButtonConstraints =  [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 55),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        let downloadButtonConstraints =  [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -55),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    // Gradient for the header
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    
    
    public func configure(with model: TitleViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)")else {
            return
        }
        heroImageView.sd_setImage(with: url, completed: nil)
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
