//////////////////////////////////////////////////////////////////////
///
/// <summary>
/// </summary>
///
///
/// <remarks>
/// </remarks>
///
///
/// <copyright>
/// Your-Company. All Rights Reserved.
/// </copyright>
///
//////////////////////////////////////////////////////////////////////
CLASS DbHelper
   EXPORTED:
      METHOD init
      METHOD CloseConnection
      METHOD ExecuteQuery, ExecuteStatement
      METHOD SQLSelect, SQLInsert, SQLUpdate, SQLDelete
      METHOD GetLastMessage
   HIDDEN:
      VAR oSession
ENDCLASS

METHOD DbHelper: init(server, db)
   IF !DbeLoad("PGDBE")
      Alert("Unable to load PostgreSQL PGDBE", {"Ok"})
   ENDIF

   DbeSetDefault("PGDBE")

   cConnect:="DBE=pgdbe; SERVER="+server+"; DB="+db+"; UID=postgres; PWD=postgres"
   ::oSession:=DacSession(): New(cConnect)
RETURN self

METHOD DbHelper: CloseConnection()
   ::oSession: disconnect()
RETURN self

METHOD DbHelper: ExecuteQuery(query)
RETURN ::oSession: ExecuteQuery(query)

METHOD DbHelper: ExecuteStatement(statement)
RETURN ::oSession: ExecuteStatement(statement)

METHOD DbHelper: SQLSelect(columns, table, whereStatement, orderBy)
   query:="SELECT "

   FOR i:=1 to Len(columns)
      query+="CASE pg_typeof("+columns[i]+") WHEN 'character'::regtype THEN ReplacePolishSymbols("+columns[i]+")"

      ::ExecuteQuery("SELECT character_maximum_length FROM information_schema.columns WHERE table_name='"+table+"' AND column_name='"+columns[i]+"'")

      IF FCount()>0 .AND. FieldGet(1)>0
         query+="::CHARACTER("+Var2Char(FieldGet(1))+")"
      ENDIF

      query+=" ELSE "+columns[i]+" END  AS t"

      IF i<Len(columns)
         query+=","
      ENDIF

      query+=" "
   NEXT

   query+=" FROM "+table

   IF whereStatement!=NIL
      query+=" WHERE "+whereStatement
   ENDIF

   IF orderBy!=NIL
      query+=" ORDER BY "+orderBy
   ENDIF

   ::ExecuteQuery(query)
RETURN query

METHOD DbHelper: SQLInsert(table, columns, values)
   statement:="INSERT INTO "+table+" ("


   FOR i:=1 to Len(columns)-1
      statement+=columns[i]+", "
   NEXT

   statement+=columns[Len(columns)]+") VALUES ("

   FOR i:=1 to Len(values)-1
      statement+="'"+HTMLWriter(): ReplacePolishSymbols(values[i])+"', "
   NEXT

   statement+="'"+HTMLWriter(): ReplacePolishSymbols(values[Len(values)])+"')"
RETURN ::ExecuteStatement(statement)

METHOD DbHelper: SQLUpdate(table, columns, values, whereStatement)
   statement:="UPDATE "+table+" SET "

   FOR i:=1 to Len(columns)-1
      statement+=columns[i]+"='"+HTMLWriter(): ReplacePolishSymbols(values[i])+"', "
   NEXT

   statement+=columns[Len(columns)]+"='"+HTMLWriter(): ReplacePolishSymbols(values[Len(columns)])+"'"
   statement+=" WHERE "+ whereStatement
RETURN ::ExecuteStatement(statement)

METHOD DbHelper: SQLDelete(table, where)
RETURN ::ExecuteStatement("DELETE FROM "+table+" WHERE "+where)

METHOD DbHelper: GetLastMessage()
//RETURN ::oSession: getLastMessage()
RETURN "<br />"