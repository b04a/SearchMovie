import UIKit
import Alamofire
import Kingfisher


class ViewController: UIViewController {
    
    @IBOutlet weak var actores: UILabel!
    @IBOutlet weak var nombrePelicula: UITextField!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var premios: UILabel!
    @IBOutlet weak var fechaLanzamiento: UILabel!
    @IBOutlet weak var tituloLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nombrePelicula.autocorrectionType = .no
    }
    
    func buscar(){
        
        if !nombrePelicula.text!.isEmpty {
            
            let nombrePelicula = nombrePelicula.text?.replacingOccurrences(of: " ", with: "%20")
            
            AF.request("http://www.omdbapi.com/?apikey=99cc4d2d&t=\(nombrePelicula ?? "")").responseDecodable(of: PeliculaModel.self) { (respuesta) in
                
                //Como le hacemos para pintar la UI
                self.tituloLabel.text = respuesta.value?.title ?? ""
                self.fechaLanzamiento.text = "Publicada: \(respuesta.value?.released ?? "")"
                self.actores.text = "Actores: \(respuesta.value?.actors ?? "")."
                
                self.premios.text = "Premios \(respuesta.value?.awards ?? "Pelicula no encontrada!")"
                
                //Crear url para mostrar
                //self.poster.loadFrom(URLAddress: respuesta.value!.Poster) //Extension
                let urlNoImage = "https://t4.ftcdn.net/jpg/02/35/35/39/360_F_235353990_f0UX1nFRDaaxHH48CU0UQ32rYxvOrPbM.jpg"
                guard let url = URL(string: respuesta.value?.poster ?? urlNoImage) else { return }
                self.poster.kf.setImage(with: url)
                
                self.nombrePelicula.text = ""
            }
        } else {
            let alerta = UIAlertController(title: "Error", message: "Escribe el nombre de una pelicula para continuar", preferredStyle: .alert)
            let accionAceptar = UIAlertAction(title: "Aceptar", style: .default) { (_) in
                print("Contacto Agregado")
            }
            
            alerta.addAction(accionAceptar)
            
            present(alerta, animated: true)
        }
        
    }
    
    
    @IBAction func buscarBtn(_ sender: UIButton) {
        buscar()
    }
    
}




