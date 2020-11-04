//
//  Login.swift
//  Ramirez Soto
//
//  Created by Mushu-Marcelo on 27/10/20.
//

import UIKit

class Login: UIViewController
{
    
    //****************************       variables interfaz      ********************************
    
        @IBOutlet weak var Campo_Correo: UITextField!
        
        @IBOutlet weak var Campo_pass: UITextField!
    
    //****************************     variables funcionamiento  ***************************************
    
    
    //**************************************************************************************************
    override func viewDidLoad()
        {
            super.viewDidLoad()
        
            //****************************       para la vista      ************************************
                Cambiar_fondo()
                
                Agrega_boton_barra_navegacion()
                Campo_Correo.background = UIImage(named: "caja_texto_usr")!
                Campo_pass.background = UIImage(named: "caja_texto_pass")!
        

            //*****************************************************************************************

            
           
        }
    
    //*************************       funciones de funcionamiento      *********************************
    @IBAction func Boton_Precionado_Login(_ sender: UIButton)
        {
            self.dismiss(animated: true)
            self.performSegue(withIdentifier: "transicion_Login_Menu", sender: self)
            //sender.setImage( UIImage(named: "boton_entrar_pres")!,for: UIControl.State.highlighted);
        }
    
    
    
    //*************************       funciones de vista e interfaz      *******************************

    
    func Alerta_Mensajes(title: String,Mensaje:String)
        {
            let Mensaje_alerta = UIAlertController(title: title, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
            let BotonAlertaOK = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            Mensaje_alerta.addAction(BotonAlertaOK)
            self.present(Mensaje_alerta,animated:true,completion:nil)
            
        }
    func Agrega_boton_barra_navegacion()
        {
            self.navigationItem.hidesBackButton = true
            let newBackButton = UIBarButtonItem(title: "Atras", style: UIBarButtonItem.Style.plain, target: self, action: #selector(Login.Funcion_Regresa(sender:)))
            self.navigationItem.leftBarButtonItem = newBackButton
        }
    @objc func Funcion_Regresa(sender: UIBarButtonItem)
        {
           exit(0)
        }
    func Cambiar_fondo()
        {
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "fondo_pantalla")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)

        }
}
