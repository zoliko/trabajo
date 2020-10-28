//
//  celda_lista_documentos.swift
//  Ramirez Soto
//
//  Created by Mushu-Marcelo on 28/10/20.
//

import UIKit

class celda_lista_documentos: UITableViewCell
{
    @IBOutlet var Area_Texto: UITextField!
    
    static let  identificador = "Celda_documentos_item"
    
    static func nib() -> UINib
        {
            return UINib(nibName: "celda_lista_documentos",bundle: nil)
        }
    
    func configurar_celda(texto: String, Seleccion: String)
        {
            switch Seleccion
                {
                    case "Actas_Constitutivas": Area_Texto.background = UIImage(named: "lista_item_acta_constitutiva")!
                    case "Actas_Extraordinarias": Area_Texto.background = UIImage(named: "lista_item_acta_extraordinaria")!
                    case "Identificaciones_Oficiales": Area_Texto.background = UIImage(named: "item_ife")!
                    case "Comprobantes_Domiciliarios": Area_Texto.background = UIImage(named: "lista_item_comprobante_domiciliario")!
                    case "Constancias_Situacion_Fiscal": Area_Texto.background = UIImage(named: "lista_item_constancia_fiscal")!
                    case "Declaraciones_Anuales": Area_Texto.background = UIImage(named: "lista_item_declaracion_anual")!
                    default: Area_Texto.background = UIImage(named: "lista_item_acta_constitutiva")!
                }
            
            Area_Texto.isUserInteractionEnabled = false;
            Area_Texto.text = texto;
        
        
        //********************
        
            /*UIGraphicsBeginImageContext(self.frame.size)
            UIImage(named: "area_lista")?.draw(in: self.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            self.backgroundColor = UIColor(patternImage: image)*/
        
            //self.backgroundView = UIImageView(image: UIImage(named: "area_lista")!)
        
            self.backgroundColor = UIColor.white.withAlphaComponent(0.0)
            
            
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
