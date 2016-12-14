# Machine Learning experiment

* Open http://studio.azureml.net --> SIGN IN (not try)
* Experiments -> Add -> blank
* Search "Restaurant ratings", move to dashboard
* RMB visualize: user, restaurant, rates (0, 1, 2)
* Search "Split data" to create training and validation
* Link dataset with splitter and set "Splitting mode: recomender"
* Search "Train matchbox" (the algorithm), move to dashboard
* Link split first output with matchbox first param
* Search "Score matchbox" (to view results), move to dashboard
* Link score first output with score first param
* Link split data second output with score second param
* Configure score matchbox: "recommended p. kind: item rec."
* Search "Evaluate recommender" (to calculate accuracy), move to dashboard
* Link Score output with Evaluate first param
* Link split data second output with evaluate second param
* Run the experiment (play button)
* MRB on score to view results (users: [resturants])
* MRB on evaluate to view accuracy (0.917)
* Click "create web service" -> "recommendation webservice"
* Search "select columns in dataset", move to dashboard
* Link "restaurant ratings" output to "select columns"
* Click select columns and launch column selector (right)
* Select "userID"
* Remove link between "Restaurant ratings" and "Score matchbox"
* Link "select columns" with "Score matchbox" second param
* Configure "Score matchbox": set "Recommended item sel: from all items"
* Run the experiment
* Deploy web service
* General -> New Web Services Experience
* Select default web service
* Test endpoint
* Set"U0177" as userID param and pres "Test request-response"
* Tachán!
* Check "consume" tab (on the top) to see how to implement clients
