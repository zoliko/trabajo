//
//  Visor.swift
//  Ramirez Soto
//
//  Created by Mushu-Marcelo on 28/10/20.
//

import UIKit
import PDFKit

class Visor: UIViewController,URLSessionDownloadDelegate,CAAnimationDelegate
{
    let shapeLayer = CAShapeLayer()
    var pdfView = PDFView()
    
        var url = String()
        var pdf_URL: URL!
        var  pdfurl: URL!

        override func viewDidLoad()
            {
                super.viewDidLoad()
                Agrega_boton_barra_navegacion()
            
                // creo visor pdf
            
                    pdfView = PDFView(frame: self.view.bounds)
                    pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    self.view.addSubview(pdfView)
                    pdfView.autoScales = true
                    pdfurl = URL(string: url)!
                    pdf_URL = pdfurl;
                
                // creo una animacion de espera
            
                    Animacion_espera()
                
            }
    
    //****************      Espera  ***************************
    
    func Animacion_espera()
        {
            let center = view.center
            let trackLayer = CAShapeLayer()
            let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
            trackLayer.path = circularPath.cgPath
            trackLayer.strokeColor = UIColor.lightGray.cgColor
            trackLayer.lineWidth = 10
            trackLayer.fillColor = UIColor.clear.cgColor
            trackLayer.lineCap = CAShapeLayerLineCap.round
            shapeLayer.path = circularPath.cgPath
            //shapeLayer.strokeColor = UIColor.red.cgColor
            shapeLayer.strokeColor = UIColor.lightGray.cgColor
            shapeLayer.lineWidth = 10
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.lineCap = CAShapeLayerLineCap.round
            shapeLayer.strokeEnd = 0
            view.layer.addSublayer(shapeLayer)
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            basicAnimation.toValue = 1
            basicAnimation.duration = 1.5
            basicAnimation.repeatCount = Float.infinity
            basicAnimation.fillMode = CAMediaTimingFillMode.forwards
            basicAnimation.isRemovedOnCompletion = true
            basicAnimation.delegate = self
            shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        }

    func animationDidStart(_ anim: CAAnimation)
        {
            pdfView.document = PDFDocument(url: pdfurl)
            pdfView.autoScales = true
            pdfView.maxScaleFactor = 4.0
            pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
            shapeLayer.removeAllAnimations()
            
            
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
                    let nuevo_botton = UIBarButtonItem(title: "Descargar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(Visor.Funcion_Descargar_pdf(sender:)))
                    self.navigationItem.rightBarButtonItem = nuevo_botton
                }
            @objc func Funcion_Descargar_pdf(sender: UIBarButtonItem)
                {
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
