//
//  CECollectionViewController.swift
//  CuriosityEye
//
//  Created by Camille Tilmont on 28/10/2017.
//  Copyright © 2017 Camille Tilmont. All rights reserved.
//

import UIKit



class CEViewControllerCollectionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var dateChoose = ""
    var photo : [Course] = []
    var cameraChoose = ""
    
    var index = 0
    var maxIndex = 0
    
    
    
    @IBOutlet var messageNoPhoto: UILabel!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet var labelCountPhotos: UILabel!
    @IBOutlet var collectionViewPhoto: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messageNoPhoto.isHidden = true
        self.collectionViewPhoto.delegate = self
        self.collectionViewPhoto.dataSource = self
        self.labelCountPhotos.text = "..."
        
        
        
        jsonDowloadingFirstLink()
    }
    
    func jsonDowloadingFirstLink(){
        
        self.loadingIndicator.hidesWhenStopped = true
        self.loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.loadingIndicator.startAnimating()
        
        
        let jsonUrlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=\(dateChoose)&camera=\(cameraChoose)&api_key=z7yuhngugEFxLfe0HcSDqTJSohjQtKJ2F2msgOyn"
        
        
        guard let url = URL(string: jsonUrlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            
            
            
            do {
                let downloadPhoto = try JSONDecoder().decode(PhotoSeries.self, from: data)
                print(1)
                print(jsonUrlString)
                print(downloadPhoto.photos)
                
                self.photo = downloadPhoto.photos
                
                
                
                
                if self.photo.count == 0{
                    DispatchQueue.main.async {
                        self.messageNoPhoto.isHidden = false
                        self.loadingIndicator.stopAnimating()
                        self.labelCountPhotos.text = "0"
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.collectionViewPhoto.reloadData()
                        self.labelCountPhotos.text = "\(self.photo.count)"
                        print(2)
                        
                        
                    }
                }
                
                
            }catch let jsonError {
                
                print("error", jsonError)
            }
            }.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    @objc func dismissFullscreenImage(_ sender: UIButton!) {
        
        if self.loadingImageIndicator.isAnimating == false{
            self.newImage.removeFromSuperview()
            self.backgroundBlack.removeFromSuperview()
        
            
        }
        
    }
    
    
    
    @objc private func pinchHandler(gesture: UIPinchGestureRecognizer) {
        if let view = gesture.view {
            
            switch gesture.state {
            case .changed:
                let pinchCenter = CGPoint(x: gesture.location(in: view).x - view.bounds.midX,
                                          y: gesture.location(in: view).y - view.bounds.midY)
                let transform = view.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                    .scaledBy(x: gesture.scale, y: gesture.scale)
                    .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
                view.transform = transform
                gesture.scale = 1
            case .ended:
                // Nice animation to scale down when releasing the pinch.
                // OPTIONAL
                UIView.animate(withDuration: 0.2, animations: {
                    view.transform = CGAffineTransform.identity
                })
            default:
                return
            }
            
            
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
       
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Erreur de Sauvegarde", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Sauvegardée !", message: "L'image a été sauvegardée dans vos photos", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
        }
    
    private var image : UIImageView!
    private var newImage : UIImageView!
    private var backgroundBlack : UIView!
    private var newBackground : UIView!
    private var loadingImageIndicator : UIActivityIndicatorView!
    private var labelCount : UILabel!
    private var buttonBack : UIButton!
    private var buttonSave : UIButton!
    
    @objc func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.right :
                print("User swiped right")
                
                // decrease index first
                
                index -= 1
                
                // check if index is in range
                
                if index < 0 {
                    
                    index = self.maxIndex
                    
                }
                
                
                
                let oldCenter = self.newImage.center
                let newCenter = CGPoint(x: oldCenter.x + self.view.frame.width, y: oldCenter.y)
                
                UIImageView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
                    self.newImage.center = newCenter
                }) { (success: Bool) in
                    print("Done moving image")
                }
                self.zoomImage(int: index)
                
                
                
                
                
            case UISwipeGestureRecognizerDirection.left:
                print("User swiped Left")
                
                // increase index first
                
                index += 1
                
                // check if index is in range
                
                if index > self.maxIndex {
                    
                    index = 0
                    
                }
                
                
                let oldCenter = self.newImage.center
                let newCenter = CGPoint(x: oldCenter.x - self.view.frame.width, y: oldCenter.y)
                
                UIImageView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
                    self.newImage.center = newCenter
                }) { (success: Bool) in
                    print("Done moving image")
                }
                self.zoomImage(int: index)
                
                
                
                
            default:
                break //stops the code/codes nothing.
                
                
            }
            
        }
        
        
    }
    
    
    
    
    
    
    @objc func buttonAction(_ sender : UIButton!){
        if self.loadingImageIndicator.isAnimating == false{
            UIImageWriteToSavedPhotosAlbum(self.newImage.image!, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)}
    }
    
    
    
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return self.photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! CECollectionViewCellPhoto
        
        if let imageUrlNew = URL(string : self.photo[indexPath.row].img_src) {
            DispatchQueue.global().async {
                let dataImage = try? Data(contentsOf: imageUrlNew)
                
                if let data = dataImage{
                    let image = UIImage(data : data)
                    DispatchQueue.main.async {
                        
                        cell.imagePhotoCuriosity.image = image
                        self.loadingIndicator.stopAnimating()
                    }
                }
            }
        } else {
            
            print("no image")
        }
        
        // Configure the cell 
        
        return cell
    }
    
  
    
  
    
    
    func zoomImage (int : Int){
        if newImage == nil {
            if let imageUrlNew = URL(string : self.photo[int].img_src) {
                
                self.loadingImageIndicator.startAnimating()
                
                DispatchQueue.global().async {
                    let dataImage = try? Data(contentsOf: imageUrlNew)
                    
                    if let data = dataImage{
                        DispatchQueue.main.async {
                            self.newImage = UIImageView(image : UIImage(data : data))
                            self.newImage.frame = CGRect(x:0, y:80, width:self.view.frame.width, height:self.view.frame.height - 160)
                            self.newImage.contentMode = .center
                            if (self.newImage.image?.size.width)! > self.view.frame.width {
                                self.newImage.contentMode = UIViewContentMode.scaleAspectFit}
                            self.newImage.isUserInteractionEnabled = true
                            
                            self.index = int
                            self.maxIndex = self.photo.count - 1
                            
                            
                            
                            
                            
                            self.newImage.isHidden = false
                            self.newImage.alpha = 0.0
                            
                            UIImageView.animate(withDuration: 0.30, delay: 0.0, options: [], animations: {
                                
                                self.newImage.alpha = 1.0
                                
                            }) { (finished: Bool) in
                                
                                self.newImage.isHidden = false
                            }
                            
                            let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchHandler(gesture:)))
                            
                            self.newImage.addGestureRecognizer(pinch)
                            
                            
                            
                            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)))
                            swipeRight.direction = UISwipeGestureRecognizerDirection.right
                            self.newImage.addGestureRecognizer(swipeRight)
                            
                            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:))) // put : at the end of method name
                            swipeLeft.direction = UISwipeGestureRecognizerDirection.left
                            self.newImage.addGestureRecognizer(swipeLeft)
                            
                            
                            self.backgroundBlack.addSubview(self.buttonBack)
                            
                            self.labelCount.text = "\(self.index+1)/\(self.photo.count)"
                            
                            self.view.addSubview(self.newImage)
                            self.loadingImageIndicator.stopAnimating()
                            
                            
                            
                        }
                        
                    }
                    
                }
                
            }
            
            
            
        }else {
            
            self.image = self.newImage
            
        if let imageUrlNew = URL(string : self.photo[int].img_src) {
            
            self.loadingImageIndicator.startAnimating()
            
            DispatchQueue.global().async {
                let dataImage = try? Data(contentsOf: imageUrlNew)
                
                if let data = dataImage{
                    DispatchQueue.main.async {
                        self.newImage = UIImageView(image : UIImage(data : data))
                        self.newImage.frame = CGRect(x:0, y:80, width:self.view.frame.width, height:self.view.frame.height - 160)

                        self.newImage.contentMode = .center
                        if (self.newImage.image?.size.width)! > self.view.frame.width {
                            self.newImage.contentMode = UIViewContentMode.scaleAspectFit}
                        self.newImage.isUserInteractionEnabled = true
                        
                        self.index = int
                        self.maxIndex = self.photo.count - 1

                       
                        
                        self.newImage.isHidden = false
                        self.newImage.alpha = 0.0
                        
                        UIImageView.animate(withDuration: 0.30, delay: 0.0, options: [], animations: {
                            
                            self.newImage.alpha = 1.0
                            
                        }) { (finished: Bool) in
                            
                            self.newImage.isHidden = false
                        }
                        
                        
                        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchHandler(gesture:)))
                        
                        self.newImage.addGestureRecognizer(pinch)
                        
                        
                        
                        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)))
                        swipeRight.direction = UISwipeGestureRecognizerDirection.right
                        self.newImage.addGestureRecognizer(swipeRight)
                        
                        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:))) // put : at the end of method name
                        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
                        self.newImage.addGestureRecognizer(swipeLeft)
                        
                       self.labelCount.text = "\(self.index+1)/\(self.photo.count)"
                        self.view.addSubview(self.newImage)
                        self.loadingImageIndicator.stopAnimating()
                        
                        
                       self.backgroundBlack.addSubview(self.buttonBack)
                        
                        self.image.removeFromSuperview()
                    }
                    
                }
                
            }
            
            }}
    }
    
    

   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.loadingImageIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        self.loadingImageIndicator.frame =  CGRect(x: self.view.frame.width/2 - 23, y: self.view.frame.height/2 - 23, width: 46, height: 46)
        self.loadingImageIndicator.hidesWhenStopped = true

        buttonSave = UIButton(frame: CGRect(x: self.view.frame.width/2 - 75, y: self.view.frame.height - 50, width: 150, height: 30))
        buttonSave.setTitle("Sauvegarder",for: .normal) 
        buttonSave.setTitleColor(UIColor.black, for: .normal)
        buttonSave.titleLabel!.font = UIFont(name: "Optima-Bold", size: 20)
        buttonSave.backgroundColor = UIColor.white
        buttonSave.layer.cornerRadius = 5
        buttonSave.addTarget(self, action: #selector(self.buttonAction(_:)) , for: .touchUpInside)
        
        buttonBack = UIButton(frame: CGRect(x: 0, y: 50, width: 100, height: 30))
        buttonBack.setTitle("Retour",for: .normal)
        buttonBack.setTitleColor(UIColor.black, for: .normal)
        buttonBack.titleLabel!.font = UIFont(name: "Optima-Bold", size: 20)
        buttonBack.backgroundColor = UIColor.white
        buttonBack.layer.cornerRadius = 5
        buttonBack.addTarget(self, action: #selector(self.dismissFullscreenImage(_:)) , for: .touchUpInside)
        
        
        labelCount = UILabel(frame: CGRect(x: self.view.frame.width/2, y: 50, width: 100, height: 30))
        labelCount.textAlignment = .center
        
        labelCount.font = UIFont(name: "Optima-Bold", size: 20)
        labelCount.textColor = .white
        
        
        self.backgroundBlack = UIView.init(frame: self.view.frame)
        self.backgroundBlack.backgroundColor = .black
        self.backgroundBlack.addSubview(self.loadingImageIndicator)
        
        self.backgroundBlack.addSubview(self.buttonSave)
        self.backgroundBlack.addSubview(labelCount)
        view.addSubview(backgroundBlack)
        zoomImage(int : indexPath.row)
        
        
    }
    
    // Use to back from full mode
    
    
}


