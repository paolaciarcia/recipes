import UIKit
import PhotosUI
import CoreData

protocol FormViewControllerDelegate: AnyObject {
    func didSaveRecipe(recipe: Recipe)
}

final class FormViewController: UIViewController {
    weak var delegate: FormViewControllerDelegate?

    private let contentView: FormView
    private var recipe = Recipe()

    var dishTextFieldCount = 0
    var portionsTextFieldCount = 0
    var timeTextFieldCount = 0
    var ingridientsCount = 0
    var instructionsCount = 0

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
            self?.recipe.name = name
        }

        contentView.didInsertPortions = { [weak self] quantity in
            guard let quantity = quantity else { return }
            self?.recipe.portions = quantity
        }

        contentView.didInsertDuration = { [weak self] time in
            guard let time = time else { return }
            self?.recipe.timePrepare = time
        }

        contentView.didInsertIngridients = { [weak self] ingridients in
            self?.recipe.ingredients = ingridients
        }

        contentView.didInsertIInstructions = { [weak self] instructions in
            self?.recipe.instructions = instructions
        }

        contentView.didTouchContinueButton = { [weak self] in
            guard let self else { return }
            self.delegate?.didSaveRecipe(recipe: self.recipe)
            self.navigationController?.popViewController(animated: true)
        }

        contentView.didTouchAddImage = { [weak self] in
            self?.createAlertController()
        }

        contentView.hasDishTextFieldEnoughCharacters = { [weak self] characterCount in
            self?.dishTextFieldCount = characterCount
            self?.setButtonState()
        }

        contentView.hasPortionsTextFieldEnoughCharacters = { [weak self] characterCount in
            self?.portionsTextFieldCount = characterCount
            self?.setButtonState()
        }

        contentView.hasTimeTextFieldEnoughCharacters = { [weak self] characterCount in
            self?.timeTextFieldCount = characterCount
            self?.setButtonState()
        }

        contentView.textViewIngridientsCount = { [weak self] characterCount in
            self?.ingridientsCount = characterCount
            self?.setButtonState()
        }

        contentView.textViewInstructionsCount = { [weak self] characterCount in
            self?.instructionsCount = characterCount
            self?.setButtonState()
        }
    }

    private func isValid() -> Bool {
        return dishTextFieldCount > 3 &&
            portionsTextFieldCount > 1 &&
            timeTextFieldCount > 1 &&
            ingridientsCount > 1 &&
            instructionsCount > 1
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
}

extension FormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        recipe.image = selectedImage
        Recipe.saveImage(selectedImage, forRecipe: recipe)
        dismiss(animated: true)
    }
}
