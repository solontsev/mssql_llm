using System;
using Microsoft.SqlServer.Server;
using System.Threading.Tasks;
using System.IO;
using System.Net;
using System.Data.SqlClient;

public class SqlServerLlmClr
{
    [Microsoft.SqlServer.Server.SqlProcedure]
    public static void HelloWorld(out string text)
    {
        SqlContext.Pipe.Send("Hello world!" + Environment.NewLine);
        text = "Hello world!";
    }

    [Microsoft.SqlServer.Server.SqlProcedure]
    public static void GeneratAndExecuteSql(string prompt, string databaseName, string model)
    {
        string databaseSchema = GetDbSchema(databaseName);
        SendLargeMessage(databaseSchema);
        SqlContext.Pipe.Send(Environment.NewLine);
        string query = GetSqlFromLlm(prompt, model, databaseName).Result;

        string result = "use [" + databaseName + "]; " + query.Replace("\\n", " ");
        SqlContext.Pipe.Send(result + Environment.NewLine);

        var cmd = new SqlCommand(result);
        SqlContext.Pipe.ExecuteAndSend(cmd);
    }

    private static async Task<string> GetSqlFromLlm(string prompt, string model, string databaseSchema)
    {
        string url = "http://localhost:11434/api/generate";
        string systemMessage = "You're a T-SQL expert working inside a SQL Server database with the following schema: " + databaseSchema + ". Please write a T-SQL query based on request, respond with the T-SQL query only as a simple string without additional text, formatting, and any special characters like tabs or end of line. Do not add anything before specified tables names. Use only names that are as provided.";
        string json = "{\"prompt\":\"" + prompt.Replace("\"", "\\\"") + "\",\"system\":\"" + systemMessage + "\",\"model\":\"" + model + "\", \"stream\":false}";

        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
        request.ContentType = "application/json; charset=utf-8";
        request.Method = "POST";

        using (var streamWriter = new StreamWriter(request.GetRequestStream()))
        {
            streamWriter.Write(json);
            streamWriter.Flush();
        }

        var httpResponse = (HttpWebResponse)request.GetResponse();
        using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
        {
            var jsonResponse = streamReader.ReadToEnd();

            string responsePrefix = "\"response\":\"";
            int startIndex = jsonResponse.IndexOf(responsePrefix) + responsePrefix.Length;
            int endIndex = jsonResponse.IndexOf("\",", startIndex);
            string response = jsonResponse.Substring(startIndex, endIndex - startIndex);

            // Replacing escaped backslash (\\) with a single backslash (\)
            response = response.Replace("\\\\", "");

            return response;
        }
    }

    private static string GetDbSchema(string databaseName)
    {
        string connectionString = "context connection=true"; // Use context connection for SQL CLR
        string result = string.Empty;
        string query = "use [" + databaseName + "];\r\n-- Temporary table to hold the concatenated column definitions\r\nDECLARE @ColumnDefinitions TABLE (TableName NVARCHAR(128), ColumnDefinition NVARCHAR(MAX));\r\n\r\n-- Populate the temporary table with column definitions for each table\r\nINSERT INTO @ColumnDefinitions (TableName, ColumnDefinition)\r\nSELECT\r\n    t.TABLE_SCHEMA + '].[' + t.TABLE_NAME,\r\n    '  [' + c.COLUMN_NAME + '] ' + c.DATA_TYPE +\r\n    CASE \r\n        WHEN c.DATA_TYPE IN ('char', 'varchar', 'nchar', 'nvarchar') \r\n             THEN '(' + CAST(c.CHARACTER_MAXIMUM_LENGTH AS NVARCHAR) + ')'\r\n        WHEN c.DATA_TYPE IN ('decimal', 'numeric') \r\n             THEN '(' + CAST(c.NUMERIC_PRECISION AS NVARCHAR) + ',' + CAST(c.NUMERIC_SCALE AS NVARCHAR) + ')'\r\n        ELSE ''\r\n    END +\r\n    CASE \r\n        WHEN c.IS_NULLABLE = 'NO' THEN ' NOT NULL'\r\n        ELSE ' NULL'\r\n    END + ', '\r\nFROM INFORMATION_SCHEMA.TABLES t\r\nINNER JOIN INFORMATION_SCHEMA.COLUMNS c\r\n    ON t.TABLE_NAME = c.TABLE_NAME AND t.TABLE_SCHEMA = c.TABLE_SCHEMA\r\nWHERE t.TABLE_TYPE = 'BASE TABLE';\r\n\r\n-- Construct CREATE TABLE statements using FOR XML PATH\r\nDECLARE @CreateTableStatements NVARCHAR(MAX) = '';\r\n\r\nSELECT @CreateTableStatements = STUFF((\r\n    SELECT CHAR(13) + CHAR(10) +\r\n           'CREATE TABLE [' + TableName + '] (' +\r\n           STUFF((\r\n               SELECT ColumnDefinition\r\n               FROM @ColumnDefinitions\r\n               WHERE TableName = t.TableName\r\n               ORDER BY ColumnDefinition\r\n               FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '') +\r\n           ')' AS CreateTableStatement\r\n    FROM (SELECT DISTINCT TableName FROM @ColumnDefinitions) t\r\n    FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '');\r\n\r\nselect @CreateTableStatements as result;";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                // Execute the query and read the result
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        result = reader.GetString(0); // Assume the result is in the first column
                    }
                }
            }
        }

        return result;
    }

    private static void SendLargeMessage(string message)
    {
        const int maxChunkSize = 4000; // Maximum length for a single message
        int length = message.Length;

        for (int i = 0; i < length; i += maxChunkSize)
        {
            string chunk = message.Substring(i, Math.Min(maxChunkSize, length - i));
            SqlContext.Pipe.Send(chunk);
        }
    }
}