//
//  Menu_Principal.swift
//  Ramirez Soto
//
//  Created by Mushu-Marcelo on 27/10/20.
//

import UIKit

class Menu_Principal: UIViewController {

    //variables de la interfaz ************************************************************
    
        @IBOutlet weak var area_nombre_empresa: UITextField!
    
    // variables de funcionamiento ********************************************************
    
    override func viewDidLoad()
        {
            super.viewDidLoad()
            
            // para mejor la vista de la pantalla *****************************************
            
                Cambiar_fondo()
                area_nombre_empresa.background = UIImage(named: "area_nombre_empresa")!
                area_nombre_empresa.isUserInteractionEnabled = false;

        }
    
    // funciones vista  *******************************************************************
    
    func Cambiar_fondo()
        {
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "fondo_pantalla")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)

        }

}
