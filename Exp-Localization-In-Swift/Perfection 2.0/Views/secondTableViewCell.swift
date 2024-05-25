//
//  secondTableViewCell.swift
//  Perfection 2.0
//
//  Created by Sidney Okine on 31/07/2022.
//

import UIKit


class secondTableViewCell: UITableViewCell {
    var actionFired : ()->Void = { }
    var didSelect = false
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
       
        
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    let heartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        button.tintColor = .gray
     
        button.isUserInteractionEnabled = true
        
        return button
    }()
    
    lazy var fruitLogo : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(fruitLogo)
        contentView.addSubview(nameLabel)
        contentView.addSubview(heartButton)
        contentView.layer.backgroundColor = UIColor.white.cgColor
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 0.5
        setupConstraints()
        selectionStyle = .none
        isUserInteractionEnabled = true
        imageView?.isUserInteractionEnabled = true
        let fruitLogoGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureFiredLogo(_:)))
        imageView?.addGestureRecognizer(fruitLogoGestureRecognizer)
        let nameLabelGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureFiredLabel(_:)))
        nameLabel.addGestureRecognizer(nameLabelGestureRecognizer)
        let heartButtonGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureFiredButton(_:)))
        heartButton.addGestureRecognizer(heartButtonGestureRecognizer)
        let contentGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureFiredContent(_:)))
        contentGestureRecognizer.numberOfTapsRequired = 2
        contentGestureRecognizer.numberOfTouchesRequired = 1
        contentView.addGestureRecognizer(contentGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
//        cellView.frame = contentView.bounds
        let margins = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
              contentView.frame = contentView.frame.inset(by: margins)
              contentView.layer.cornerRadius = 8
        let imageViewMargins = UIEdgeInsets(top: 15, left: 5, bottom: 30, right: 50)
        imageView!.frame = (imageView?.frame.inset(by: imageViewMargins))!
    }
    
    func setupConstraints(){
        let nameLabelConstraints = [nameLabel.leadingAnchor.constraint(equalTo: imageView!.trailingAnchor, constant: 20), nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                                    nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(nameLabelConstraints)
        
        
        let buttonConstraints = [heartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
                                 heartButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(buttonConstraints)
//        let logoConstraints = [fruitLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5), fruitLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
//
//        ]
//        NSLayoutConstraint.activate(logoConstraints)
    }
    
    func render(fruitName: String, image: String, btnImage: UIImage){
        self.nameLabel.text = fruitName
        self.imageView?.image = UIImage(named: image)
        self.heartButton.setImage(btnImage, for: .normal)
        
    }
    
    @objc func gestureFiredButton(_ gesture: UITapGestureRecognizer){
        actionFired()
        print("Gesture Triggered On Button")
        self.didSelect = !self.didSelect
        if self.didSelect {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartButton.tintColor = .red
        }
        else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            heartButton.tintColor = .gray
        }
        
    }
    @objc func gestureFiredLogo(_ gesture: UITapGestureRecognizer){
        actionFired()
        print("Gesture Triggered On Logo")
        self.didSelect = !self.didSelect
        if self.didSelect {
            imageView?.layer.cornerRadius = 8
            imageView?.layer.backgroundColor = UIColor.gray.cgColor
            
            
            
        }
        else {
            imageView?.layer.backgroundColor = UIColor.white.cgColor

        }
        
        
    }
    @objc func gestureFiredLabel(_ gesture: UITapGestureRecognizer){
        actionFired()
        print("Gesture Triggered On \(nameLabel.text ?? "Fruit")")
        self.didSelect = !self.didSelect
        if self.didSelect{
            nameLabel.textColor = .red
        }
        else {
            nameLabel.textColor = .black
            
        }
        
        
    }
    @objc func gestureFiredContent(_ gesture: UITapGestureRecognizer){
        actionFired()
        print("Gesture Triggered On Content")
        self.didSelect = !self.didSelect
        if self.didSelect{
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartButton.tintColor = .red
            
//            let keyWindow = UIApplication.shared.connectedScenes
//                    .filter({$0.activationState == .foregroundActive})
//                    .compactMap({$0 as? UIWindowScene})
//                    .first?.windows
//                    .filter({$0.isKeyWindow}).first
            
            let alert = UIAlertController(title: "Successful".localised(), message: "You double-tapped".localised() + String(nameLabel.text!).localised(), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localised(), style: .default, handler: nil)
              alert.addAction(okAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
//            keyWindow?.endEditing(true)
        }
        else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            heartButton.tintColor = .gray
            
        }
        
        
    }
    
    
    
}
