

import UIKit
import PhotosUI
import CoreData

class FormViewController: UIViewController {

    var didInsertDishName: ((_ text: String?) -> Void)?
    var didInsertPortions: ((_ quantity: String?) -> Void)?
    var didInsertDuration: ((_ time: String?) -> Void)?
    var didInsertIngridients: ((String) -> Void)?
    var didInsertIInstructions: ((String) -> Void)?
    var isButtonEnable: ((Bool) -> Void)?

    var recipe: Recipe?
    private let contentView: FormView

//    @IBOutlet weak var addFoodImageView: UIButton!
//    @IBOutlet weak var navigationBar: UINavigationItem!
//    @IBAction func generateRecipe(_ sender: Any) {
//        updateRecipe()
//        if recipe.isValid() {
//            performSegue(withIdentifier: "NovaReceita", sender: nil)
//        } else {
//            let alert = UIAlertController(title: "Receita inválida!", message: "Por favor, preencha todos os campos", preferredStyle: .alert)
//            let action = UIAlertAction(title: "OK", style: .default, handler: { action in
//                
//            })
//            alert.addAction(action)
//            present(alert, animated: true)
//        }
//    }

    init(contentView: FormView = FormView()) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
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

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nova Receita"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .black
        updateRecipe()
//        addFoodImageView.isUserInteractionEnabled = true
//        NotificationCenter.default.addObserver(self, selector: #selector(updateRecipe), name: UIResponder.keyboardDidHideNotification, object: nil)
//        ingredientsTextView.addDoneButton()
//        instructionsTextView.addDoneButton()
    }
    
//    @objc func updateRecipe() {
//        recipe.name = foodNameTextField.text ?? ""
//        recipe.ingredients = ingredientsTextView.text ?? ""
//        recipe.instructions = instructionsTextView.text ?? ""
//
//        if let time = prepareTimeTextField.text,
//           let portions = servesTextField.text {
//            recipe.timePrepare = Int(time) ?? 0
//            recipe.portions = Int(portions) ?? 0
//        }
//    }

    private func updateRecipe() {
        contentView.didInsertDishName = { [weak self] name in
            guard let name = name else { return }
            self?.recipe?.name = name
        }

        contentView.didInsertPortions = { [weak self] quantity in
            guard let quantity = quantity,
                  let quantityPortions = Int(quantity) else { return }
            self?.recipe?.portions = quantityPortions
        }

        contentView.didInsertDuration = { [weak self] time in
            guard let time = time,
                  let duration = Int(time) else { return }
            self?.recipe?.timePrepare = duration
        }

        contentView.didInsertIngridients = { [weak self] ingridients in
//            guard let ingridients = ingridients else { return }
            self?.recipe?.ingredients = ingridients
        }

        contentView.didInsertIInstructions = { [weak self] instructions in
//            guard let instructions = instructions else { return }
            self?.recipe?.instructions = instructions
        }

        contentView.didTouchContinueButton = { [weak self] in
            self?.setupNavigation()
        }
    }

    private func setupNavigation() {
        let viewController = DetailViewController(recipe: recipe ?? Recipe())
        viewController.isNewRecipe = true
        navigationController?.pushViewController(viewController, animated: false)
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "NovaReceita" {
//
//            guard let detailViewController = segue.destination as? DetailViewController else {
//                return
//            }
//            
//            detailViewController.recipe = recipe
//            detailViewController.isNewRecipe = true
//        }
//    }
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
        recipe?.image = selectedImage
//        addFoodImageView.imageView?.image = selectedImage
        Recipe.saveImage(selectedImage, forRecipe: recipe ?? Recipe())
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


