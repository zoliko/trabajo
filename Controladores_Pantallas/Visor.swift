//
//  Visor.swift
//  Ramirez Soto
//
//  Created by Mushu-Marcelo on 28/10/20.
//

import UIKit
import PDFKit

class Visor: UIViewController,URLSessionDownloadDelegate
{
    
    
        var url = String()
        var pdf_URL: URL!

        override func viewDidLoad()
            {
                super.viewDidLoad()
            
                //self.Alerta_Mensajes(title:"debug",Mensaje:"esto me enviaste: \(url)")
                print(url)
            
                Agrega_boton_barra_navegacion()
            
            
            // Add PDFView to view controller.
               let pdfView = PDFView(frame: self.view.bounds)
               pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
               self.view.addSubview(pdfView)
               
               // Fit content in PDFView.
               pdfView.autoScales = true
               
               // Load Sample.pdf file from app bundle.
            
               let  pdfurl = URL(string: url)!
                
                pdf_URL = pdfurl;
            
                pdfView.document = PDFDocument(url: pdfurl)
                pdfView.autoScales = true
                pdfView.maxScaleFactor = 4.0
                pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit

                
            }
    //**************************************************************
        func Alerta_Mensajes(title: String,Mensaje:String)
            {
                let Mensaje_alerta = UIAlertController(title: title, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
                let BotonAlertaOK = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                Mensaje_alerta.addAction(BotonAlertaOK)
                self.present(Mensaje_alerta,animated:true,completion:nil)
                
            }
        //**************************************************************
            func Agrega_boton_barra_navegacion()
                {
                    //self.navigationItem.hidesBackButton = true
                    let nuevo_botton = UIBarButtonItem(title: "Descargar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(Visor.Funcion_Descargar_pdf(sender:)))
                    self.navigationItem.rightBarButtonItem = nuevo_botton
                }
            @objc func Funcion_Descargar_pdf(sender: UIBarButtonItem)
                {
                   //exit(0)
                        guard let url = URL(string: url) else { return }
                        
                        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
                        
                        let downloadTask = urlSession.downloadTask(with: url)
                        downloadTask.resume()
                }
    
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL)
            {
                
                print("downloadLocation:", location)
                guard let url = downloadTask.originalRequest?.url else { return }
                let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
                
                // delete original copy
                
                    try? FileManager.default.removeItem(at: destinationURL)
                        
                // copy from temp to Document
                        do
                            {
                                try FileManager.default.copyItem(at: location, to: destinationURL)
                                self.pdf_URL = destinationURL
                                print("Estoy en : \(destinationURL)")
                            }
                        catch let error { print("Copy Error: \(error.localizedDescription)")}
            }
        
    }
