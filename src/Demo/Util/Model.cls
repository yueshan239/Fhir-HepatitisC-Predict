Class Demo.Util.Model
{

/// d ##Class(Demo.Util.Model).CreateView()
ClassMethod CreateView()
{
	Set Status =$$$OK
	Set sql = "create view T2.HepatitisData as "
			_" SELECT "
			_"    TP.ID, TP.BirthDate, DATEDIFF(yy,TP.BirthDate,Now()) AGE, TP.Gender, TP.Key,"
			_"    GH.CodeText GHCodeText, GH.ValueBoolean GHGHValueBoolean,"
			_"    ALB.ValueQuantityValue ALBValueQuantityValue,"
			_"    ALP.ValueQuantityValue ALPValueQuantityValue, "
			_"    ALT.ValueQuantityValue ALTValueQuantityValue,"
			_"    AST.ValueQuantityValue ASTValueQuantityValue,"
			_"    BIL.ValueQuantityValue BILValueQuantityValue, "
			_"    CHE.ValueQuantityValue CHEValueQuantityValue,"
			_"    CHOL.ValueQuantityValue CHOLValueQuantityValue,"
			_"    CREA.ValueQuantityValue CREAValueQuantityValue,"
			_"    GGT.ValueQuantityValue GGTValueQuantityValue,"
			_"    PROT.ValueQuantityValue"
			_" FROM "
			_"    T2.Patient TP"
			_"    INNER JOIN T2.Observation GH ON TP.Key = GH.SubjectReference AND GH.CodeCodingCode = '8310-5'"
			_"    INNER JOIN T2.Observation ALB ON TP.Key = ALB.SubjectReference AND ALB.CodeCodingCode = '1751-7'"
			_"    INNER JOIN T2.Observation ALP ON TP.Key = ALP.SubjectReference AND ALP.CodeCodingCode = '6768-6'"
			_"    INNER JOIN T2.Observation ALT ON TP.Key = ALT.SubjectReference AND ALT.CodeCodingCode = '29463-7'"
			_"    INNER JOIN T2.Observation AST ON TP.Key = AST.SubjectReference AND AST.CodeCodingCode = '2345-7'"
			_"    INNER JOIN T2.Observation BIL ON TP.Key = BIL.SubjectReference AND BIL.CodeCodingCode = '1975-2'"
			_"    INNER JOIN T2.Observation CHE ON TP.Key = CHE.SubjectReference AND CHE.CodeCodingCode = '1920-8'"
			_"    INNER JOIN T2.Observation CHOL ON TP.Key = CHOL.SubjectReference AND CHOL.CodeCodingCode = '2093-3'"
			_"    INNER JOIN T2.Observation CREA ON TP.Key = CREA.SubjectReference AND CREA.CodeCodingCode = '2160-0'"
			_"    INNER JOIN T2.Observation GGT ON TP.Key = GGT.SubjectReference AND GGT.CodeCodingCode = '2324-2'"
			_"    INNER JOIN T2.Observation PROT ON TP.Key = PROT.SubjectReference AND PROT.CodeCodingCode = '2885-2'"
	Set tStatement = ##class(%SQL.Statement).%New()
    Set Status = tStatement.%Prepare(sql)
    Set rset = tStatement.%Execute()
    Quit Status
}

/// d ##Class(Demo.Util.Model).CreateModel()
ClassMethod CreateModel() As %Status
{
	Set Status =$$$OK
	Set sql="CREATE MODEL Hepatitis PREDICTING (GHCodeText) WITH"
			_" ( AGE int, Gender string, GHGHValueBoolean boolean, ALBValueQuantityValue double,"
			_"  ALPValueQuantityValue double, ALTValueQuantityValue double, ASTValueQuantityValue double, "
			_"  BILValueQuantityValue double, CHEValueQuantityValue double, CHOLValueQuantityValue double, "
			_"  CREAValueQuantityValue double, GGTValueQuantityValue double, ValueQuantityValue double) FROM T2.HepatitisData "
	Set tStatement = ##class(%SQL.Statement).%New()
    Set Status = tStatement.%Prepare(sql)
    Set rset = tStatement.%Execute()
    Quit Status
}

/// d ##Class(Demo.Util.Model).TrainModel()
ClassMethod TrainModel()
{
	Set Status =$$$OK
	Set sql="TRAIN MODEL Hepatitis "
	Set tStatement = ##class(%SQL.Statement).%New()
    Set Status = tStatement.%Prepare(sql)
    Set rset = tStatement.%Execute()
    Quit Status
}

}

