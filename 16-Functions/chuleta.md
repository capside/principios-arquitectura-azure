#Chuleta Function

1) Crear Azure Function app
    Compute -> Function App 
               -> Rellenar:
               Nombre de función
               Nuevo RG
               Hosting Plan -> Consumption Plan
               Storage Account -> Nueva
               Location -> WestEurope
               Storage Account -> Por defecto

2) Crear 3 containers en la SA (ojo a los nombres)
    uploaded
    accepted
    rejected

3) Editar la función
        New Function -> C# + Scenario Core + BlobTrigger-CSharp
        Name -> BlobImageAnalysis
        Path -> Uploaded/{name}
        Storage account connection -> AzureWebJobsDashboard
    -> Create
        Meter el código de funcion.cs
    -> save
    -> Add (para meter un fichero nuevo)
        Añadir project.json
        Meter el contenido del fichero
    -> save

4) Dar de alta una subscripción al API Cognitiva
   Obtener una clave de API para el API "Computer Vision"
   Hay que habilitar el account creation (temperamental)
   Una vez creada, obtener el "API Key"
   Volver a la funcion -> "Function app settings"
      "Manage -> Go to App Service Settings"
      Application Settings -> App Setings
          Meter el KV
          SubscriptionKey - LaClaveDelAPI

   Scroll hasta la funcion (BlobImageAnalisys)
   Run -> Esperamos un 202 y una excepcion

5) Probamos la funcion subiendo fotos al contenedor "Uploaded"
