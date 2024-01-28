# Fhir-HepatitisC-Predict
Processing FHIR resources through FHIR SQL BUILDER will predict the probability of suffering from HepatitisC disease
![image](https://community.intersystems.com/sites/default/files/inline/images/images/image(8151).png)
### Pre condition: Ability to use FHIR and ML
Firstly, our dataset is obtained from kaggle and transformed into FHIR resources based on patient gender, age, ALP or ALT, and imported into the FHIR resource repository

To import the FHIR resource repository, we can use this command:

 ``` 
 Set sc=##class(HS.FHIRServer.Tools.DataLoader).SubmitResourceFiles("/usr/local/src/json/","FHIRSERVER","/csp/healthshare/fhirserver/fhir/r4")
 ```

 Among them, the file address and fhir resource repository URL can be modified according to the situation.
 ![image.png](https://community.intersystems.com/sites/default/files/inline/images/images/image(8147).png)

 ### After completing the import, the next step is to configure FHIR SQL Builder, including FHIR Analysis, conversion rules, and Projections

 ![image](https://community.intersystems.com/sites/default/files/inline/images/images/image(8148).png)

### Configure conversion rules, which are very important. They can obtain the data you want, and some sensitive information of patients can also be omitted, ensuring data security
![image](https://community.intersystems.com/sites/default/files/inline/images/images/image(8149).png)

### After configuration is completed, create a projection to query the corresponding table in the database

![image](https://community.intersystems.com/sites/default/files/inline/images/images/image(8150).png)

### After the projection is created, summarize the tables into the required structure for training by creating tables or views
````
create view T2.HepatitisData AS
SELECT
    TP.ID, TP.BirthDate, DATEDIFF(yy,TP.BirthDate,Now()) AGE, TP.Gender, TP.Key,
    GH.CodeText GHCodeText, GH.ValueBoolean GHGHValueBoolean,
    ALB.ValueQuantityValue ALBValueQuantityValue,
    ALP.ValueQuantityValue ALPValueQuantityValue, 
    ALT.ValueQuantityValue ALTValueQuantityValue,
    AST.ValueQuantityValue ASTValueQuantityValue,
    BIL.ValueQuantityValue BILValueQuantityValue, 
    CHE.ValueQuantityValue CHEValueQuantityValue,
    CHOL.ValueQuantityValue CHOLValueQuantityValue,
    CREA.ValueQuantityValue CREAValueQuantityValue,
    GGT.ValueQuantityValue GGTValueQuantityValue,
    PROT.ValueQuantityValue
FROM
    T2.Patient TP
    INNER JOIN T2.Observation GH ON TP.Key = GH.SubjectReference AND GH.CodeCodingCode = '8310-5'
    INNER JOIN T2.Observation ALB ON TP.Key = ALB.SubjectReference AND ALB.CodeCodingCode = '1751-7'
    INNER JOIN T2.Observation ALP ON TP.Key = ALP.SubjectReference AND ALP.CodeCodingCode = '6768-6'
    INNER JOIN T2.Observation ALT ON TP.Key = ALT.SubjectReference AND ALT.CodeCodingCode = '29463-7'
    INNER JOIN T2.Observation AST ON TP.Key = AST.SubjectReference AND AST.CodeCodingCode = '2345-7'
    INNER JOIN T2.Observation BIL ON TP.Key = BIL.SubjectReference AND BIL.CodeCodingCode = '1975-2'
    INNER JOIN T2.Observation CHE ON TP.Key = CHE.SubjectReference AND CHE.CodeCodingCode = '1920-8'
    INNER JOIN T2.Observation CHOL ON TP.Key = CHOL.SubjectReference AND CHOL.CodeCodingCode = '2093-3'
    INNER JOIN T2.Observation CREA ON TP.Key = CREA.SubjectReference AND CREA.CodeCodingCode = '2160-0'
    INNER JOIN T2.Observation GGT ON TP.Key = GGT.SubjectReference AND GGT.CodeCodingCode = '2324-2'
    INNER JOIN T2.Observation PROT ON TP.Key = PROT.SubjectReference AND PROT.CodeCodingCode = '2885-2'
````

## Create Model
````
CREATE MODEL Hepatitis PREDICTING (GHCodeText) WITH ( AGE int, Gender string, GHGHValueBoolean boolean, ALBValueQuantityValue double, ALPValueQuantityValue double, ALTValueQuantityValue double, ASTValueQuantityValue double, BILValueQuantityValue double, CHEValueQuantityValue double, CHOLValueQuantityValue double, CREAValueQuantityValue double, GGTValueQuantityValue double, ValueQuantityValue double) FROM T2.HepatitisData 
````
## Training model
````
TRAIN model Hepatitis
````
## After the training is completed, we can use this model for HepatitisC prediction, which is the application interface

### 1.After the configuration is completed, initialization will be carried out, and the dataset in HepatitsCdata.csv will be processed into FHIR resources and imported　
### 2.Show can display the normal range of input check results　
### 3.After completing all inputs, click on the prediction button to convert the filled information into fhir resources and store them in the FHIR resource repository through the API. This allows for result prediction of Hepatitis C diseases
![image](https://community.intersystems.com/sites/default/files/inline/images/images/image(8151).png)