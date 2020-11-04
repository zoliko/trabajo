//
//  Lista.swift
//  Ramirez Soto
//
//  Created by Mushu-Marcelo on 28/10/20.
//

import UIKit


class Lista: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    var datos_Tabla = ["doc_1.pdf","doc_2.pdf","doc_3.pdf","doc_4.pdf"]
    var valor = 0;
    
    //variables  de la pantalla   *******************************************************
    
    @IBOutlet weak var tabla_lista: UITableView!
    
    
    //variables enviadas de la pantalla anterior  ***********************************
        
        var Selecction: String?
    
    
    // **********************************************************************************

        override func viewDidLoad()
            {
                super.viewDidLoad()
            
                // codigo para la vista de la pantlla ***********************************
                    Cambiar_fondo()
                    Cambiar_fondo_lista()
            
            
                // codigo vista tabla ***********************************
                    self.tabla_lista.register(celda_lista_documentos.nib(), forCellReuseIdentifier: celda_lista_documentos.identificador)
                    self.tabla_lista.dataSource = self
                    self.tabla_lista.delegate = self

                
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
}
