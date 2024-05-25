//
//  TableView.swift
//  Perfection 2.0
//
//  Created by Sidney Okine on 28/07/2022.
//

import UIKit


class TableView: UIView {
    let firstTableViewCell = TableViewCell()
    let SecondTableViewCell = secondTableViewCell()
    let Colors = ["Red","Yellow","Green","Blue","Purple","Brown","Pink","Gray","Teal","Orange"]
    let Fruits = ["Apple","Blueberry","Cherry","Gooseberry","Grapefruit","Lemon","Lime","Mango","Pear","Plum","Pomegranate","Strawberry","Watermelon" ]
    var didLike = Array(repeating: false, count: 13)

    lazy var TableViewHolder : UITableView = {
       let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TableViewCell.self, forCellReuseIdentifier: "colorCell")
        table.register(secondTableViewCell.self, forCellReuseIdentifier: "fruitCell")
        table.allowsSelection = true
        table.isScrollEnabled = true
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    let HeaderLabel : UILabel = {
        let label = UILabel()
        label.text = "Basic iOS Controls".localised()
        label.numberOfLines = 0
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
      return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(HeaderLabel)
        addSubview(TableViewHolder)
        setupConstraints()
        TableViewHolder.reloadData()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //Setup Constraints....... No copy and paste !!!!
    func setupConstraints(){
        let headerConstraints = [HeaderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                                 HeaderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50)
        ]
        NSLayoutConstraint.activate(headerConstraints)
        
        let tableViewConstraints = [TableViewHolder.topAnchor.constraint(equalTo: HeaderLabel.bottomAnchor, constant: 10), TableViewHolder.leadingAnchor.constraint(equalTo: leadingAnchor), TableViewHolder.trailingAnchor.constraint(equalTo: trailingAnchor), TableViewHolder.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    //Another button inside the tableview cell
    //When tableview is clicked an action should be performed
    //A button to perform an action different action
    
    
}
extension TableView : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
        case 0: return Colors.count
        default: return Fruits.count
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
        case 0: return "Colors".localised()
        default: return "Fruits".localised()
        }
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch(indexPath.section){
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath) as! TableViewCell
            cell.render(buttonName: Colors[indexPath.row].localised())
            cell.contentView.backgroundColor = UIColor(named: Colors[indexPath.row])
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "fruitCell", for: indexPath) as! secondTableViewCell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            cell.render(fruitName: Fruits[indexPath.row].localised(), image: Fruits[indexPath.row], btnImage: UIImage(systemName: "heart")!)
            cell.heartButton.addTarget(self, action: #selector(heartTapped(sender:)), for: .touchUpInside)
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch(indexPath.section){
        case 0:
            return 70
        default:
            return 100
        }
        
    }
    
    @objc func gestureFired(_ gesture: UITapGestureRecognizer){
        print("Gesture Triggered")

        self.SecondTableViewCell.heartButton.setImage(UIImage(systemName: "heart.fill")!, for: .normal)
        SecondTableViewCell.heartButton.tintColor = .red
        
    }
    
    
    @objc func heartTapped(sender: UIButton){
      // use the tag of button as index
        
        if sender.tag == 2 {
            print("heart button tapped")

        }
        let fruitLiked = Fruits[sender.tag]
        let alert = UIAlertController(title: "New Favorite".localised(), message: "New favourite fruit is \(fruitLiked.localised())".localised(), preferredStyle: .alert)
          let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
          alert.addAction(okAction)
                
    }
    
}

