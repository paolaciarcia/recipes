

import UIKit
import PhotosUI

class FormViewController: UIViewController {
    
    let recipe = Receita(name: "", ingredients: "", instructions: "", image: UIImage.init())

    @IBOutlet weak var foodNameTextField: UITextField!
    @IBOutlet weak var servesTextField: UITextField!
    @IBOutlet weak var prepareTimeTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var addFoodImageView: UIButton!
    @IBOutlet weak var navigationBar: UINavigationItem!
    

    @IBAction func generateRecipe(_ sender: Any) {
        updateRecipe()
        if recipe.isValid() {
            performSegue(withIdentifier: "NovaReceita", sender: nil)
        } else {
            let alert = UIAlertController(title: "Receita inválida!", message: "Por favor, preencha todos os campos", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { action in
                
            })
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)

    }
    
    @IBAction func updateImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        let alertController = UIAlertController(
            title: "Escolha uma imagem",
            message: nil,
            preferredStyle: .actionSheet
        )
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(
                UIAlertAction(
                    title: "Câmera",
                    style: .default,
                    handler: { _ in
                        imagePicker.sourceType = .camera
                        self.present(imagePicker, animated: true)
                    }
                )
            )
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alertController.addAction(
                UIAlertAction(
                    title: "Biblioteca",
                    style: .default,
                    handler: { _ in
                        imagePicker.sourceType = .photoLibrary
                        self.present(imagePicker, animated: true)
                    }
                )
            )
        }
        
        alertController.addAction(
            UIAlertAction(title: "Cancelar",style: .destructive,handler: nil)
        )
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFoodImageView.isUserInteractionEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(updateRecipe), name: UIResponder.keyboardDidHideNotification, object: nil)
        ingredientsTextView.addDoneButton()
        instructionsTextView.addDoneButton()
    }
    
    @objc func updateRecipe() {
        recipe.name = foodNameTextField.text ?? ""
        recipe.ingredients = ingredientsTextView.text ?? ""
        recipe.instructions = instructionsTextView.text ?? ""
        recipe.timePrepare = Int(prepareTimeTextField.text ?? "")
        recipe.serves = Int(servesTextField.text ?? "")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "NovaReceita" {

            guard let detailViewController = segue.destination as? DetailViewController else {
                return
            }
            detailViewController.recipe = recipe
            detailViewController.isNewRecipe = true
        }
    }
}

extension FormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
extension FormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        addFoodImageView.imageView?.image = selectedImage
        Receita.saveImage(selectedImage, forRecipe: recipe)
        dismiss(animated: true)
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
}

extension UITextView {
    func addDoneButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.resignFirstResponder))
        toolbar.items = [flexSpace, doneButton]
        self.inputAccessoryView = toolbar
    }
}


