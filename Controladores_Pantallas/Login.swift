//
//  Login.swift
//  Ramirez Soto
//
//  Created by Mushu-Marcelo on 27/10/20.
//

import UIKit
import Alamofire
class Login: UIViewController, UITextFieldDelegate
{
    
    //****************************       variables interfaz      ********************************
    
        @IBOutlet weak var Campo_Correo: UITextField!
        @IBOutlet weak var Campo_pass: UITextField!
    
    
    
    //****************************     variables funcionamiento  ***************************************
    
        var correo_usr:String = ""
        var pass_usr:String = ""
        var id_Empresa = String()
        var Nombre_Empresa = String()
    
    
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
        
            Campo_Correo.delegate = self
            Campo_pass.delegate = self
            
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
            self.view.addGestureRecognizer(tap)
            
        }
    
    //*************************       ocultar teclado     *********************************************
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer)
        {
            Campo_Correo.resignFirstResponder()
            Campo_pass.resignFirstResponder()
        
        }
    deinit
            {
                
                NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillHideNotification, object: nil)
            NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
            }
    
        func Ocultar_teclado()
            {
                if Campo_Correo.isFirstResponder { Campo_Correo.resignFirstResponder()}
                if Campo_pass.isFirstResponder { Campo_pass.resignFirstResponder()}
            }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
        {
            Ocultar_teclado()
            return true
        }
    @objc func keyboardWillChange(notification: Notification)
        {
        let temp  = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let keyboardSize = (temp?.height)!
            switch notification.name.rawValue
                {
            case "UIKeyboardWillShowNotification":view.frame.origin.y = (-1.0 * keyboardSize)
                    case "UIKeyboardWillHideNotification":view.frame.origin.y = 0
                    default:view.frame.origin.y = 0
                
                }
            
            
        }
    //*************************       funciones de funcionamiento      *********************************
    @IBAction func Boton_Precionado_Login(_ sender: UIButton)
        {
            Ocultar_teclado()
        
            correo_usr = Campo_Correo.text!
            pass_usr = Campo_pass.text!
        
            if correo_usr.isEmpty || pass_usr.isEmpty
                {
                    Alerta_Mensajes(title:"Upps...",Mensaje:"VERIFICA QUE TODOS LOS CAMPOS ESTEN LLENOS")
                    return
                }
        
            Servicio_web_Login(Usr: correo_usr, Pass: pass_usr)
        
            
        }
    
    
    
    //*************************       funciones de vista e interfaz      *******************************

    
    func Alerta_Mensajes(title: String,Mensaje:String)
        {
            let Mensaje_alerta = UIAlertController(title: title, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
            let BotonAlertaOK = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            Mensaje_alerta.addAction(BotonAlertaOK)
            self.present(Mensaje_alerta,animated:true,completion:nil)
            
        }

    func Cambiar_fondo()
        {
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "fondo_pantalla")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)

        }
    func Agrega_boton_barra_navegacion()
        {
            self.navigationItem.hidesBackButton = true
            let newBackButton = UIBarButtonItem(title: "Salir", style: UIBarButtonItem.Style.plain, target: self, action: #selector(Login.Funcion_Regresa(sender:)))
            self.navigationItem.leftBarButtonItem = newBackButton
        }
    @objc func Funcion_Regresa(sender: UIBarButtonItem)
        {
           exit(0)
        }
    
    //*************************       funciones      *******************************
    
    func Servicio_web_Login( Usr:String , Pass: String)
        {
            let Servicio_web_url = "https:www.dev-mushu.xyz/Files_Gestor_Soto/Drivers/Inicio_Sesion.php"
            let parametros : Parameters =
                                            [
                                                "Correo": Usr,
                                                "Password": Pass
                                            ]
        
            AF.request(Servicio_web_url, method: .post, parameters: parametros).responseJSON
                {
                    (response) in
                    switch response.result
                        {
                            case .success(let data):
                                let jsonData = data as! NSDictionary
                                let Variable_Control_json = (jsonData.value(forKey:"exito") as! String?)!
                                if Variable_Control_json == "Verdadero"
                                    {
                                        let Datos_json = (jsonData.value(forKey:"datos") as? [[String:Any]])!
                                        let elementos =  Datos_json.count
                                            
                                        if elementos != 1
                                            {
                                                self.Alerta_Mensajes(title:"Upps...",Mensaje:"verifica tus datos")
                                                return
                                            }
                                        else
                                            {
                                                self.id_Empresa = (Datos_json[0]["ID_Empresa"] as! String?)!
                                                self.Nombre_Empresa = (Datos_json[0]["Empresa_Nombre"] as! String?)!
                                                        
                                                UserDefaults.standard.set(true, forKey: "estado_login")
                                                UserDefaults.standard.set(self.Nombre_Empresa, forKey: "Nombre_Empresa")
                                                UserDefaults.standard.set(self.id_Empresa, forKey: "id_Empresa")
                                                
                                                //************
                                                    self.correo_usr = ""
                                                    self.pass_usr = ""
                                                    self.id_Empresa = String()
                                                    self.Nombre_Empresa = String()
                                                    
                                                    self.Campo_Correo.text = ""
                                                    self.Campo_pass.text = ""
                                                //************
                                                        
                                                self.dismiss(animated: true)
                                                self.performSegue(withIdentifier: "transicion_Login_Menu", sender: self)
                                            }
                                    }
                                else
                                    {
                                        self.Alerta_Mensajes(title:"Upps...",Mensaje:"Se encontro un error en el servidor, lamentamos la molestia")
                                        return
                                    }
                            case .failure(let error):
                                print("Request failed with error: \(error)")
                        }
                }
        }
}
