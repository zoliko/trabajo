//
//  Lista.swift
//  Ramirez Soto
//
//  Created by Mushu-Marcelo on 28/10/20.
//

import UIKit
import Alamofire

class Lista: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    var datos_Tabla = [String]()
    var valor = 0;
    
    //variables  de la pantalla   *******************************************************
    
    @IBOutlet weak var tabla_lista: UITableView!
    @IBOutlet weak var area_nombre_empresa: UITextField!
    
    
    //variables enviadas de la pantalla anterior  ***********************************
        
        var Selecction: String?
        var Id_Empresa: String?
    
    
    // **********************************************************************************

        override func viewDidLoad()
            {
        
                super.viewDidLoad()
            
                // codigo para la vista de la pantlla ***********************************
                    Cambiar_fondo()
                    Cambiar_fondo_lista()
                //*******
            
                    area_nombre_empresa.background = UIImage(named: "area_nombre_empresa")!
                    area_nombre_empresa.isUserInteractionEnabled = false;
                    var temp = Selecction?.replacingOccurrences(of: "_", with: " ")
                    area_nombre_empresa.text = temp
            
            
                // codigo vista tabla ***********************************
                    self.tabla_lista.register(celda_lista_documentos.nib(), forCellReuseIdentifier: celda_lista_documentos.identificador)
                    self.tabla_lista.dataSource = self
                    self.tabla_lista.delegate = self
            
                // datos del servidor
                    
                    Servicio_web_Lista_identificaciones(ID_Solicitado: Id_Empresa!)
            
                

                
            }
    // funcionalidad  *******************************************************************
    
        func Alerta_Mensajes(title: String,Mensaje:String)
            {
                let Mensaje_alerta = UIAlertController(title: title, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
                let BotonAlertaOK = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                Mensaje_alerta.addAction(BotonAlertaOK)
                self.present(Mensaje_alerta,animated:true,completion:nil)
                
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
        func Cambiar_fondo_lista()
            {
                UIGraphicsBeginImageContext(self.tabla_lista .frame.size)
                UIImage(named: "area_lista")?.draw(in: self.tabla_lista.bounds)
                let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                tabla_lista.backgroundColor = UIColor(patternImage: image)
            }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
            {
                return datos_Tabla.count
            }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
            {
                let celda = tableView.dequeueReusableCell(withIdentifier: celda_lista_documentos.identificador, for: indexPath) as! celda_lista_documentos
                celda.configurar_celda(texto: datos_Tabla[indexPath.row], Seleccion: Selecction!)
                return celda
            }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
            {
                //print(indexPath.row)
                self.dismiss(animated: true)
                self.performSegue(withIdentifier: "transicion_Lista_visor", sender: self)
            }
    //*************************       funciones servidor web*******************************
    
    func Servicio_web_Lista_identificaciones( ID_Solicitado:String)
        {
        
            var Servicio_web_url = ""
        
            switch Selecction
                {
                    case "Actas_Constitutivas":
                        Servicio_web_url = "https:www.dev-mushu.xyz/Files_Gestor_Soto/Drivers/"
                    case "Actas_Extraordinarias":
                        Servicio_web_url = "https:www.dev-mushu.xyz/Files_Gestor_Soto/Drivers/"
                    case "Identificaciones_Oficiales":
                        Servicio_web_url = "https:www.dev-mushu.xyz/Files_Gestor_Soto/Drivers/Lista_Identificacion.php"
                    case "Comprobantes_Domiciliarios":
                        Servicio_web_url = "https:www.dev-mushu.xyz/Files_Gestor_Soto/Drivers/"
                    case "Constancias_Situacion_Fiscal":
                        Servicio_web_url = "https:www.dev-mushu.xyz/Files_Gestor_Soto/Drivers/"
                    case "Declaraciones_Anuales":
                        Servicio_web_url = "https:www.dev-mushu.xyz/Files_Gestor_Soto/Drivers/"
                    default:
                        print("no hay nada")
                }
            let parametros : Parameters =
                                            [
                                                "ID_Empresa": ID_Solicitado
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
                                        
                                    //print("Hay :\(elementos) elementos")
                                            
                                    if elementos == 0
                                        {
                                            self.Alerta_Mensajes(title:"Upps...",Mensaje:"no hay aun documentos visibles, estamos trabajando en ello")
                                            return
                                        }
                                    else
                                        {
                                            for elemento in Datos_json
                                            {
                                                let elemento_obtenido = (elemento["Representante_Nombre"] as! String?)!
                                                self.datos_Tabla.append(elemento_obtenido)
                                            }
                                            self.tabla_lista.reloadData()
                                            
                                                
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
