import UIKit
import PhotosUI
import CoreData

final class FormViewController: UIViewController {
    private let contentView: FormView
    private var recipeModel = RecipeModel()

    init(contentView: FormView = FormView()) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
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
        bindLayoutEvents()
        setButtonState()
    }

    private func bindLayoutEvents() {
        contentView.didInsertDishName = { [weak self] name in
            guard let name = name else { return }
            self?.recipeModel.dishName = name
        }

        contentView.didInsertPortions = { [weak self] quantity in
            guard let quantity = quantity else { return }
            self?.recipeModel.portions = quantity
        }

        contentView.didInsertDuration = { [weak self] time in
            guard let time = time else { return }
            self?.recipeModel.time = time
        }

        contentView.didInsertIngridients = { [weak self] ingridients in
            self?.recipeModel.ingridients = ingridients
        }

        contentView.didInsertIInstructions = { [weak self] instructions in
            self?.recipeModel.instructions = instructions
        }

        contentView.didTouchAddImage = { [weak self] in
            self?.createAlertController()
        }

        contentView.hasDishTextFieldEnoughCharacters = { [weak self] characterCount in
            self?.recipeModel.dishTextFieldCount = characterCount
            self?.setButtonState()
        }

        contentView.hasPortionsTextFieldEnoughCharacters = { [weak self] characterCount in
            self?.recipeModel.portionsTextFieldCount = characterCount
            self?.setButtonState()
        }

        contentView.hasTimeTextFieldEnoughCharacters = { [weak self] characterCount in
            self?.recipeModel.timeTextFieldCount = characterCount
            self?.setButtonState()
        }

        contentView.textViewIngridientsCount = { [weak self] characterCount in
            self?.recipeModel.ingridientsCount = characterCount
            self?.setButtonState()
        }

        contentView.textViewInstructionsCount = { [weak self] characterCount in
            self?.recipeModel.instructionsCount = characterCount
            self?.setButtonState()
        }

        contentView.didTouchContinueButton = { [weak self] in
            self?.saveRecipeToRealm()
            self?.navigationController?.popViewController(animated: true)
        }
    }

    private func isValid() -> Bool {
        return recipeModel.dishTextFieldCount > 3 &&
        recipeModel.portionsTextFieldCount > 1 &&
        recipeModel.timeTextFieldCount > 1 &&
        recipeModel.ingridientsCount > 1 &&
        recipeModel.instructionsCount > 1
    }

    private func setButtonState() {
        if isValid() {
            contentView.continueButton.backgroundColor = .systemBlue
            contentView.continueButton.setTitleColor(.white, for: .normal)
            contentView.continueButton.isEnabled = true
        } else {
            contentView.continueButton.backgroundColor = .systemGray4
            contentView.continueButton.setTitleColor(.systemGray, for: .normal)
            contentView.continueButton.isEnabled = false
        }
    }

    private func createAlertController() {
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

    private func saveRecipeToRealm() {
        DataBaseHelper.saveRecipe(recipeModel: recipeModel)
    }
}

extension FormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        let pngData = selectedImage.pngData()
//        recipeModel.dishImage = pngData
        dismiss(animated: true)
    }
}
