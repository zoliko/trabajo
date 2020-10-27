//
//  Login.swift
//  Ramirez Soto
//
//  Created by Mushu-Marcelo on 27/10/20.
//

import UIKit

class Login: UIViewController {
    
    //****************************       variables interfaz      ********************************
    
        @IBOutlet weak var Campo_Correo: UITextField!
        
        @IBOutlet weak var Campo_pass: UITextField!
    
    //****************************     variables funcionamiento  ********************************
    
    
    //*******************************************************************************************
    override func viewDidLoad()
        {
            super.viewDidLoad()
        
            //****************************       para la vista      ********************************
                
                Agrega_boton_barra_navegacion()
                Campo_Correo.background = UIImage(named: "caja_texto_usr")!
                Campo_pass.background = UIImage(named: "caja_texto_pass")!

            //********************************************

            
           
        }
    
    //funciones ****************************************************
    @objc func Funcion_Regresa(sender: UIBarButtonItem)
        {
           exit(0)
            //_ = navigationController?.popViewController(animated: true)
        }
    
    func Alerta_Mensajes(title: String,Mensaje:String)
        {
            let AlertaPerso = UIAlertController(title: title, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
            let BotonAlertaOK = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            
            AlertaPerso.addAction(BotonAlertaOK)
            self.present(AlertaPerso,animated:true,completion:nil)
            
        }
    
    //funciones ************************************************************************************
    func Agrega_boton_barra_navegacion()
        {
            self.navigationItem.hidesBackButton = true
            let newBackButton = UIBarButtonItem(title: "Atras", style: UIBarButtonItem.Style.plain, target: self, action: #selector(Login.Funcion_Regresa(sender:)))
            self.navigationItem.leftBarButtonItem = newBackButton
        }
    /*func addLeftImageTo(txtField: UITextField, andImage img: UIImage)
        {
            let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
            leftImageView.image = img
            txtField.leftView = leftImageView
            txtField.leftViewMode = .always
        
          
        
            txtField.background = UIImage(named: "caja_texto_usr")!
            

        
        }*/
    /*func cambia_fondo_contenedor_login()
        {
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "cuadro_dialogo_inicio.png")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            fondo_login.backgroundColor = UIColor(patternImage: image)
        }*/
    

    
}
