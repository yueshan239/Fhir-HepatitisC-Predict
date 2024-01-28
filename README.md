# Fhir-HepatitisC-Predict
Processing FHIR resources through FHIR SQL BUILDER will predict the probability of suffering from HepatitisC disease

### Pre condition: Ability to use FHIR and ML
Firstly, our dataset is obtained from kaggle and transformed into FHIR resources based on patient gender, age, ALP or ALT, and imported into the FHIR resource repository

To import the FHIR resource repository, we can use this command:

 `Set sc=##class(HS.FHIRServer.Tools.DataLoader).SubmitResourceFiles("/usr/local/src/json/","FHIRSERVER","/csp/healthshare/fhirserver/fhir/r4")`
 
 ![image](https://community.intersystems.com/sites/default/files/inline/images/images/image(8147).png)