//
//  AddGearViewController.swift
//  MountainGearCollection
//
//  Created by Christian Wasmer on 05/03/2017.
//  Copyright © 2017 Christian Wasmer. All rights reserved.
//

import UIKit

class AddGearViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var gearImageView: UIImageView!
    @IBOutlet weak var itemNameText: UITextField!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var gear : Gear? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if gear != nil {
            gearImageView.image = UIImage(data: (gear!.image) as! Data)
            itemNameText.text = gear?.title
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        gearImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(gear!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
        
    }
    
    
    
    
    @IBAction func addTapped(_ sender: Any) {
        
        if gear != nil {
            gear!.title = itemNameText.text
            gear!.image = UIImagePNGRepresentation(gearImageView.image!) as NSData!
            
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let gear = Gear(context: context)
            gear.title = itemNameText.text
            gear.image = UIImagePNGRepresentation(gearImageView.image!) as NSData!
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
        
    }
}
