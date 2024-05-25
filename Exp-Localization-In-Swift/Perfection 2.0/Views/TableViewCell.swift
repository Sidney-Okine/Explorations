//
//  TableViewCell.swift
//  Perfection 2.0
//
//  Created by Sidney Okine on 28/07/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    var actionFired : ()->Void = { }

    var didSelect = false


    
// A button
    //Different types of cell
    //Title and an image
    //Title and a progressbar
    // Different type of cells in the tableview
    //Different tableviewcells into the tableview
    
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        label.isUserInteractionEnabled = true
        
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.backgroundColor = .white
        setupConstraints()
        selectionStyle = .none
        isUserInteractionEnabled = true
        let nameTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureFiredLabel(_:)))
        nameLabel.addGestureRecognizer(nameTapGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    func setupConstraints(){
        let nameLabelConstraints = [nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(nameLabelConstraints)
    }
    
    func render(buttonName: String){
        self.nameLabel.text = buttonName
    }
  
 
    @objc func gestureFiredLabel(_ gesture: UITapGestureRecognizer){
        actionFired()
        print("Gesture Triggered On \(nameLabel.text ?? "Fruit")")
        self.didSelect = !self.didSelect
        if self.didSelect{
            contentView.backgroundColor = UIColor(named: nameLabel.text!)
        }
        else {
            contentView.backgroundColor = UIColor.white
        }
        
        
    }
}
