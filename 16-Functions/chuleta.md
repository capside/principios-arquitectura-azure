Authors: Javier Moreno (Ciberado), Mario Arienza (Cowbotic)
Copyright 2017 CAPSiDE SL (www.capside.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

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
    * Path -> `uploaded/{name}`
    * Storage account connection -> AzureWebJobsDashboard
    * -> Create
        * Meter el código de funcion.cs
    * -> save
    * -> Add (para meter un fichero nuevo)
        * Añadir project.json
        * Meter el contenido del fichero
    * -> save
    
4. Dar de alta una subscripción al API Cognitiva
   * Obtener una clave de API para el API "Computer Vision"
   * Hay que habilitar el account creation (temperamental)
   * Una vez creada, obtener el "API Key"
   * Volver a la funcion -> "Function app settings"
      * "Manage -> Go to App Service Settings"
      * Application Settings -> App Setings
        * Meter el KV
        * SubscriptionKey - LaClaveDelAPI

   * Scroll hasta la funcion (BlobImageAnalisys)
   * Run -> Esperamos un 202 y una excepcion

5. Probamos la funcion subiendo fotos al contenedor "Uploaded"
