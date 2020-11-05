//
//  ViewController.swift
//  Ramirez Soto
//
//  Created by Mushu-Marcelo on 27/10/20.
//

import UIKit

class ViewController: UIViewController {

    // variables de funcionamiento
    
        var estado_login = false

    override func viewDidLoad()
        {
            super.viewDidLoad()
            Cambiar_fondo()
            Verifica_Logueo()
        
            
            
            
        
        
        }
        
    func Verifica_Logueo()
            {
                estado_login = (UserDefaults.standard.object(forKey: "estado_login") != nil)
    
                if estado_login == true
                    {
                        let timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(transicion_Splash_Menu), userInfo: nil, repeats: false)
                    }
                else
                    {
                        let timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(transicion_Splash_Login), userInfo: nil, repeats: false)
                    }
            }
    @objc func transicion_Splash_Login()
        {
            self.dismiss(animated: true)
            self.performSegue(withIdentifier: "transicion_Splash_Login", sender: self)
        }
    @objc func transicion_Splash_Menu()
        {
            self.dismiss(animated: true)
            self.performSegue(withIdentifier: "transicion_Splash_Menu", sender: self)
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

