//
//  Menu_Principal.swift
//  Ramirez Soto
//
//  Created by Mushu-Marcelo on 27/10/20.
//

import UIKit

class Menu_Principal: UIViewController {

    // informacion guardada por el usuario
    
        var id_Empresa = String()
        var Nombre_Empresa = String()
    
    
    //variables de la interfaz ************************************************************
    
        @IBOutlet weak var area_nombre_empresa: UITextField!
    
    // variables de funcionamiento ********************************************************
    
    override func viewDidLoad()
        {
            super.viewDidLoad()
            
            // para mejor la vista de la pantalla *****************************************
        
                Agrega_boton_barra_navegacion()
                Obtener_informacion()
                Cambiar_fondo()
                area_nombre_empresa.background = UIImage(named: "area_nombre_empresa")!
                area_nombre_empresa.isUserInteractionEnabled = false;
                area_nombre_empresa.text = Nombre_Empresa
        
            // para mejor la vista de la pantalla *****************************************

        }
    // recuperar informacion
    
    func Obtener_informacion()
            {
                id_Empresa = UserDefaults.standard.string(forKey: "id_Empresa") ??  String()
                Nombre_Empresa = UserDefaults.standard.string(forKey: "Nombre_Empresa") ?? String()
    
            }
    // funcionalidad  *******************************************************************
    
        @IBAction func Menu_boton_precionado(_ sender: UIButton)
            {
                let identificador_boton = sender.tag
                var cadena:String = ""
                
                switch identificador_boton
                    {
                        case 0: cadena = "Actas_Constitutivas"
                        case 1: cadena = "Actas_Extraordinarias"
                        case 2: cadena = "Identificaciones_Oficiales"
                        case 3: cadena = "Comprobantes_Domiciliarios"
                        case 4: cadena = "Constancias_Situacion_Fiscal"
                        case 5: cadena = "Declaraciones_Anuales"
                        default: cadena = ""
                    }
            
                self.dismiss(animated: true)
                self.performSegue(withIdentifier: "transicion_Menu_Lista", sender: cadena)
            }
    
    
        func Alerta_Mensajes(title: String,Mensaje:String)
            {
                let Mensaje_alerta = UIAlertController(title: title, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
                let BotonAlertaOK = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                Mensaje_alerta.addAction(BotonAlertaOK)
                self.present(Mensaje_alerta,animated:true,completion:nil)
                
            }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?)
            {
                if (segue.identifier == "transicion_Menu_Lista")
                    {
                        let Selecction = sender as! String
                        let Nueva_Pantalla_Lista: Lista = segue.destination as! Lista
                        Nueva_Pantalla_Lista.Selecction = Selecction
                    }
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
        func Agrega_boton_barra_navegacion()
            {
                self.navigationItem.hidesBackButton = true
                let newBackButton = UIBarButtonItem(title: "Cerrar Sesion", style: UIBarButtonItem.Style.plain, target: self, action: #selector(Menu_Principal.cerrar_Sesion(sender:)))
                self.navigationItem.rightBarButtonItem = newBackButton
            }
    @objc func cerrar_Sesion(sender: UIBarButtonItem)
        {
            UserDefaults.standard.set(false, forKey: "estado_login")
            UserDefaults.standard.set(String(), forKey: "Nombre_Empresa")
            UserDefaults.standard.set(String(), forKey: "id_Empresa")
            //exit(0)
            self.navigationController?.popViewController(animated: true)
        
        }

}
