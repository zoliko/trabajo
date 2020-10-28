//
//  ViewController.swift
//  Ramirez Soto
//
//  Created by Mushu-Marcelo on 27/10/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad()
        {
            super.viewDidLoad()
            Cambiar_fondo()
        
            
            
            let timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(Contador_splash_Screen), userInfo: nil, repeats: false)
        
        
        }
        
    func Verifica_Logueo()
            {
                
            }

    @objc func Contador_splash_Screen()
        {
            self.dismiss(animated: true)
            self.performSegue(withIdentifier: "transicion_Splash_Login", sender: self)
        
        }
    func Cambiar_fondo()
        {
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "splash_screen_press")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)

        }


}

