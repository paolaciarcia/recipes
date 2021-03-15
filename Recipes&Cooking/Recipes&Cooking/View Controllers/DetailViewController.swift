
import UIKit
import PhotosUI

class DetailViewController: UIViewController {
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var prepareTimeLabel: UILabel!
    @IBOutlet weak var servesLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UILabel!
    @IBOutlet weak var instructionsTextView: UILabel!
    
    var recipe: Receita?
    var isNewRecipe = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        foodImageView.image = recipe?.image
        foodNameLabel.text = recipe?.name
        prepareTimeLabel.text = "\(String(describing: recipe!.timePrepare!))"
        servesLabel.text = "\(String(describing: recipe!.serves!))"
        ingredientsTextView.text = recipe?.ingredients
        instructionsTextView.text = recipe?.instructions
        
        if isNewRecipe {
            let saveButton = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(saveRecipe))
            let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelRecipe))
            
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.leftBarButtonItem = cancelButton
        }
    }

    @objc func cancelRecipe() {
        performSegue(withIdentifier: "CancelRecipe", sender: nil)
    }
    
    @objc func saveRecipe() {
        NotificationCenter.default.post(name: .RecipeSaved, object: recipe)
        performSegue(withIdentifier: "SaveRecipe", sender: nil)
    }
}

extension Notification.Name {
    static let RecipeSaved = Notification.Name("SaveRecipe")
}

        

