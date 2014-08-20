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

   FOR i:=1 to Len(columns)-1
      query+=columns[i]+", "
   NEXT

   query+=columns[Len(columns)]
   query+=" FROM "+table

   IF whereStatement!=NIL
      query+=" WHERE "+whereStatement
   ENDIF

   IF orderBy!=NIL
      query+=" ORDER BY "+orderBy
   ENDIF

   ::ExecuteQuery(query)
RETURN self

METHOD DbHelper: SQLInsert(table, columns, values)
   statement:="INSERT INTO "+table+" ("

   FOR i:=1 to Len(columns)-1
      statement+=columns[i]+", "
   NEXT

   statement+=columns[Len(columns)]+") VALUES ("

   FOR i:=1 to Len(values)-1
      statement+="'"+HTMLWriter(): ReplaceBushes(values[i])+"', "
   NEXT

   statement+="'"+HTMLWriter(): ReplaceBushes(values[Len(values)])+"')"
RETURN ::ExecuteStatement(statement)

METHOD DbHelper: SQLUpdate(table, columns, values, whereStatement)
   statement:="UPDATE "+table+" SET "

   FOR i:=1 to Len(columns)-1
      statement+=columns[i]+"='"+HTMLWriter(): ReplaceBushes(values[i])+"', "
   NEXT

   statement+=columns[Len(columns)]+"='"+HTMLWriter(): ReplaceBushes(values[Len(columns)])+"'"
   statement+=" WHERE "+ whereStatement
RETURN ::ExecuteStatement(statement)

METHOD DbHelper: SQLDelete(table, where)
RETURN ::ExecuteStatement("DELETE FROM "+table+" WHERE "+where)

METHOD DbHelper: GetLastMessage()
RETURN ::oSession: getLastMessage()