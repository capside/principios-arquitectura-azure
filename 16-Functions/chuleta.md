# Chuleta Function

1. Crear Azure Function app
   * Compute -> Function App 
     * Rellenar :
       * Nombre de funcion
       * Nuevo RG
       * Hosting Plan -> Consumption Plan
       * Storage Account -> Nueva
       * Location -> WestEurope
       * Storage Account -> Por defecto
       
2. Crear 3 containers en la SA (ojo a los nombres)
    * uploaded
    * accepted
    * rejected

3. Editar la función
    * New Function -> C# + Scenario Core + BlobTrigger-CSharp
    * Name -> BlobImageAnalysis
    * Path -> `Uploaded/{name}`
    * Storage account connection -> AzureWebJobsDashboard
    * -> Create
        * Meter el código de funcion.cs
    * -> save
    * -> Add (para meter un fichero nuevo)
        * Añadir project.json
        * Meter el contenido del fichero
    * -> save
