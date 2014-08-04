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