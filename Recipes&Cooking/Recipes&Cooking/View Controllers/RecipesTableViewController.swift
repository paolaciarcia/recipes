

import UIKit

class RecipesTableViewController: UITableViewController {
    
    var recipe = [Receita]()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateRecipeList(notification:)), name: .RecipeSaved, object: nil)
        tableView.reloadData()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipe.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(RecipeCell.self)", for: indexPath) as? RecipeCell else { fatalError("Could not create RecipeCell") }
        
        cell.recipeImage.image = recipe[indexPath.row].image
        cell.recipeImage.layer.cornerRadius = 10
        cell.titleLabel.text = recipe[indexPath.row].name
        cell.servesLabel.text = "Porções: \(recipe[indexPath.row].serves!)"
        cell.timePrepareLabel.text = "Tempo de Preparo: \(recipe[indexPath.row].timePrepare!) min"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipes = recipe[indexPath.row]
        performSegue(withIdentifier: "ShowRecipe", sender: recipes)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipe" {

            
            guard let recipeViewController = segue.destination as?
                    DetailViewController,
                  let recipe = sender as? Receita else {
                return
            }
            
            recipeViewController.recipe = recipe
            
        }
        
        if segue.identifier == "AddRecipeSegue" {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        }
    }
        
    
    @IBAction func saveRecipe(unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func cancelRecipe(unwindSegue: UIStoryboardSegue) {

    }
    
    @objc func updateRecipeList(notification: Notification) {
        guard let recipes = notification.object as? Receita else {
            return
        }
        recipe.append(recipes)
        tableView.reloadData()
    }
    
    // MARK: - Table view Delegate
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        recipe.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
}
