//
//  AutoLayoutExtensions.swift
//  Perfection 2.0
//
//  Created by Sidney Okine on 28/07/2022.
//

import UIKit

extension UIView{
    
    func setWithAnchor(_ width: CGFloat){
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    func setHW(_ height:CGFloat , _ width: CGFloat){
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setHeightAnchor(_ width: CGFloat){
        self.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setWidth(_ width: CGFloat){
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(_ height: CGFloat){
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    func setHeightAndWidth(_ height: CGFloat, _ width: CGFloat){
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.widthAnchor.constraint(equalToConstant: width).isActive = true

    }
    
    func centerX(_ view : UIView, _ space:CGFloat = 0.0){
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: space).isActive = true
    }
    func centerY(_ view : UIView, _ space:CGFloat = 0.0 ){
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: space).isActive = true
    }
    
    func centerVerticalToView(_ view : UIView){
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerHorizontalToView(_ view : UIView){
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    func pintoLeft(superview: UIView,space: CGFloat = 0.0){
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor,constant: space).isActive = true
    }
    
    func pintoLeftAndRight(leftSuperview: UIView,lspace: CGFloat = 0.0,
                    rightSuperview: UIView,rspace: CGFloat = 0.0){
        
        
        self.leadingAnchor.constraint(equalTo: leftSuperview.leadingAnchor,constant: lspace).isActive = true
        self.trailingAnchor.constraint(equalTo: rightSuperview.trailingAnchor,constant: rspace).isActive = true

    }
    
    
    func pintoLeft(superview: NSLayoutAnchor<NSLayoutXAxisAnchor>,space: CGFloat = 0.0){
        self.leadingAnchor.constraint(equalTo: superview,constant: space).isActive = true
    }
    
    
    func pintoLeftAndRight(lsuperview: NSLayoutAnchor<NSLayoutXAxisAnchor>,lspace: CGFloat = 0.0,
                           rsuperview: NSLayoutAnchor<NSLayoutXAxisAnchor>,rspace: CGFloat = 0.0){
        self.leadingAnchor.constraint(equalTo: lsuperview,constant: lspace).isActive = true
        self.trailingAnchor.constraint(equalTo: rsuperview,constant: rspace).isActive = true

    }
    
    func pintoRight(superview: UIView,space: CGFloat = 0.0){
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor,constant: space).isActive = true
    }
    
    func pintoRight(superview: NSLayoutAnchor<NSLayoutXAxisAnchor>,space: CGFloat = 0.0){
        self.leadingAnchor.constraint(equalTo: superview,constant: space).isActive = true
    }
    func pintoTop(superview: UIView,space: CGFloat = 0.0){
        self.topAnchor.constraint(equalTo: superview.topAnchor,constant: space).isActive = true
    }
    //
    func pintoTop(superview: NSLayoutYAxisAnchor,space: CGFloat = 0.0){
        self.topAnchor.constraint(equalTo: superview,constant: space).isActive = true
    }
    
    func pintoBottom(superview: NSLayoutYAxisAnchor,space: CGFloat = 0.0){
        self.bottomAnchor.constraint(equalTo: superview,constant: space).isActive = true
    }
    
    
    func pintoBottom(superview: UIView,space: CGFloat = 0.0){
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor,constant: space).isActive = true
    }
    
    
    func constraintoTop(superview view : UIView,
                                            topSpace : CGFloat = 0,
                                            leadingSpace : CGFloat = 0,
                                            trailingSpace : CGFloat = 0){
        self.topAnchor.constraint(equalTo: view.topAnchor,constant: topSpace).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: leadingSpace).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: trailingSpace).isActive = true
    }
    
    func setHeightAndWith(_ width: CGFloat,_ height: CGFloat){
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    
    func constrainToSuperViewNoGuide(on view : UIView){
        //let guide = view.safeAreaLayoutGuide
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
    }
    func constrainToBelowView(below view : UIView){
        
        
        let guide = view.safeAreaLayoutGuide
        
        
        self.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func constrainToSuperView(on view : UIView,
                                                        top: CGFloat = 0,
                                                        leading:CGFloat = 0,
                                                        trailing:CGFloat = 0,
                                                        bottom: CGFloat = 0){
        
        let guide = view.safeAreaLayoutGuide
        
        self.leadingAnchor.constraint(equalTo: guide.leadingAnchor,constant: leading).isActive = true
        self.trailingAnchor.constraint(equalTo: guide.trailingAnchor,constant: trailing).isActive = true
        self.bottomAnchor.constraint(equalTo: guide.bottomAnchor,constant: bottom).isActive = true
        self.topAnchor.constraint(equalTo: guide.topAnchor,constant: top).isActive = true
        
    }
    
    func constrainTopOfSuperView(on view : UIView,topConstant:CGFloat = 0,
                                                             leadingConstant:CGFloat = 0,
                                                             trailingConstant : CGFloat = 0){
        let guide = view.safeAreaLayoutGuide
        
        self.leadingAnchor.constraint(equalTo: guide.leadingAnchor,constant: leadingConstant).isActive = true
        self.trailingAnchor.constraint(equalTo: guide.trailingAnchor,constant: trailingConstant).isActive = true
        self.topAnchor.constraint(equalTo: guide.topAnchor,constant: topConstant).isActive = true
        
    }
    
   
    func constrainBelowSuperViewsTopView(superview : UIView,
                                                                             below topview : UIView,
                                                                             spacing: CGFloat = 0){
        
        let guide = superview.safeAreaLayoutGuide
        
        self.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        self.topAnchor.constraint(equalTo: topview.bottomAnchor,constant: spacing).isActive = true
        
    }
    
    
    
    func constrainBelowView(below: UIView,
                                                    topSpace:CGFloat = 0,
                                                    bottomSpace:CGFloat = 0,
                                                    leadingSpace:CGFloat = 0,
                                                    tralingSpace:CGFloat = 0 ,withBottomAchor:Bool = false){
        
        
        self.topAnchor.constraint(equalTo: below.bottomAnchor,constant: topSpace).isActive = true
        self.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: leadingSpace).isActive = true
        self.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: tralingSpace).isActive = true
        if withBottomAchor {
            self.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: bottomSpace).isActive = true
        }
        
    }
    

    func createDashedLine(color: UIColor, strokeLength: NSNumber, gapLength: NSNumber, width: CGFloat) {
        let from  = CGPoint(x: self.frame.midX, y: self.bounds.minY)
        let to = CGPoint(x: self.frame.midX, y: self.bounds.minY)
        let shapeLayer = CAShapeLayer()

         shapeLayer.strokeColor = color.cgColor
         shapeLayer.lineWidth = width
         shapeLayer.lineDashPattern = [strokeLength, gapLength]

         let path = CGMutablePath()
         path.addLines(between: [from, to])
         shapeLayer.path = path
         layer.addSublayer(shapeLayer)
    }
    }
    

