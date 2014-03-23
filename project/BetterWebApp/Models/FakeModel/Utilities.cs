using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Configuration; 

// SQL THINGS
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace BetterWebApp.Models
{
    public static class Utilities
    {
        private static bool[] updateLists;
        private static DateTime lastUpdate;
        static Utilities() 
        {
            updateLists = new bool[] { true, true, true, true, true, true, true };
            lastUpdate = DateTime.Now;
        }
        private static void needUpdate() 
        {
            if (DateTime.Now.Subtract(lastUpdate).TotalMinutes >= 10)
            {
                updateLists = new bool[] { true, true, true, true, true, true, true }; // Flag all for update
                lastUpdate = DateTime.Now;
                lUsers.Clear();
                lElements.Clear();
                lFixedCharacters.Clear();
                lUserCharacters.Clear();
                lExercises.Clear();
                lBattles.Clear();
                lHallOfFames.Clear();
            }
        }

        // Declare lists representing tables in a database.
        private static List<User> lUsers = new List<User>();
        public static List<User> users
        {
            get
            {
                needUpdate();
                if (updateLists[0]) // Get a fresh copy from database
                {
                    updateLists[0] = false;
                    List<Object> results = selectQuery("SELECT * FROM tbl_USERS"); // Do query
                    List<User> userList = new List<User>();
                    foreach (List<Object> result in results) // Loop through rows
                    {
                        // Cast the columns
                        int id = (int)result[0];
                        string username = (string)result[1];
                        string email = (string)result[2];
                        string parentEmail = (string)result[3];
                        string hashedPassword = (string)result[4];
                        DateTime registrationDate = (DateTime)result[5];
                        bool isActivated = (bool)result[6];
                        bool isVisible = (bool)result[7];
                        bool isPublic = (bool)result[8];
                        int totalXP = (int)result[9];
                        int exerciseXP = (int)result[10];
                        userList.Add(new User(id, username, email, parentEmail, hashedPassword, registrationDate, isActivated, isVisible, isPublic, totalXP, exerciseXP));
                    }
                    lUsers.AddRange(userList); // Return the list of users
                }
                return lUsers;
            }
        }
        private static List<Element> lElements = new List<Element>();
        public static List<Element> elements
        {
            get
            {
                needUpdate();
                if (updateLists[1]) // Get a fresh copy from database
                {
                    updateLists[1] = false;
                    List<Object> results = selectQuery("SELECT * FROM tbl_ELEMENT"); // Do query
                    List<Element> elements = new List<Element>();
                    foreach (List<Object> result in results) // Loop through rows
                    {
                        // Cast the columns
                        int id = (int)result[0];
                        string name = (string)result[1];
                        string description;
                        try { description = (string)result[2]; }
                            catch { description = ""; }
                        double damagePoints = (double)result[3];
                        double defencePoints = (double)result[4];
                        double damageVariation = (double)result[5];
                        double defenceVariation = (double)result[6];
                        int xpPerLevel = (int)result[7];
                        int opposite = (int)result[8];

                        elements.Add(new Element(id, name, description, opposite, damagePoints, defencePoints, damageVariation, defenceVariation, xpPerLevel));
                    }
                    lElements.AddRange(elements); // Return the list of users
                }
                return lElements;
            }
        }
        private static List<FixedCharacter> lFixedCharacters = new List<FixedCharacter>();
        public static List<FixedCharacter> fixedCharacters
        {
            get
            {
                needUpdate();
                if (updateLists[2]) // Get a fresh copy from database
                {
                    updateLists[2] = false;
                    List<Object> results = selectQuery("SELECT * FROM tbl_FIXED_CHARACTER"); // Do query
                    List<FixedCharacter> fixedCharacters = new List<FixedCharacter>();
                    foreach (List<Object> result in results) // Loop through rows
                    {
                        // Cast the columns
                        int id = (int)result[0];
                        string name = (string)result[1];
                        string description;
                        try { description = (string)result[2]; }
                            catch { description = ""; }
                        string imageFileName;
                        try { imageFileName = (string)result[3]; }
                            catch { imageFileName = ""; }
                        int elementID = (int)result[4];
                        double damagePointsOverride;
                        try { damagePointsOverride = (double)result[5]; }
                            catch { damagePointsOverride = -1.0; }
                        double defencePointsOverride;
                        try { defencePointsOverride = (double)result[6]; }
                            catch { defencePointsOverride = -1.0; }
                        double damageVariationOverride;
                        try { damageVariationOverride = (double)result[7]; }
                            catch { damageVariationOverride = -1.0; }
                        double defenceVariationOverride;
                        try { defenceVariationOverride = (double)result[8]; }
                            catch { defenceVariationOverride = -1.0; }
                        int xpPerLevelOverride;
                        try { xpPerLevelOverride = (int)result[9]; }
                            catch { xpPerLevelOverride = -1; }
                        fixedCharacters.Add(new FixedCharacter(id, elementID, name, description, imageFileName, damagePointsOverride, defencePointsOverride, damageVariationOverride, defenceVariationOverride, xpPerLevelOverride));
                    }
                    lFixedCharacters.AddRange(fixedCharacters);
                }
                return lFixedCharacters; // Return the list of users
            }
        }
        private static List<UserCharacter> lUserCharacters = new List<UserCharacter>();
        public static List<UserCharacter> userCharacters
        {
            get
            {
                needUpdate();
                if (updateLists[3])
                {
                    updateLists[3] = false;
                    List<Object> results = selectQuery("SELECT * FROM tbl_USER_CHARACTER"); // Do query
                    List<UserCharacter> userCharacters = new List<UserCharacter>();
                    foreach (List<Object> result in results) // Loop through rows
                    {
                        // Cast the columns
                        int id = (int)result[0];
                        string name = (string)result[1];
                        int xp = (int)result[2];
                        DateTime birth = (DateTime)result[3];
                        string imageFileName;
                        try { imageFileName = (string)result[4]; }
                            catch { imageFileName = ""; }
                        int fixedCharacterId = (int)result[5];
                        int ownerId = (int)result[6];
                        bool isActivated = Convert.ToBoolean((bool)result[7]);
                        bool isVisible = (bool)result[8];
                        userCharacters.Add(new UserCharacter(id, name, xp, birth, imageFileName, isActivated, isVisible, fixedCharacterId, ownerId));
                    }
                    lUserCharacters.AddRange(userCharacters); // Return the list of users
                }
                return lUserCharacters;
            }
        }
        private static List<Exercise> lExercises = new List<Exercise>();
        public static List<Exercise> exercises
        {
            get
            {
                needUpdate();
                if (updateLists[4])
                {
                    updateLists[4] = false;
                    List<Object> results = selectQuery("SELECT * FROM tbl_EXERCISE"); // Do query
                    List<Exercise> exercises = new List<Exercise>();
                    foreach (List<Object> result in results) // Loop through rows
                    {
                        // Cast the columns
                        int id = (int)result[0];
                        int userID = (int)result[1];
                        DateTime date = (DateTime)result[2];
                        int shakes = (int)result[3];
                        bool isValid = (bool)result[4];
                        exercises.Add(new Exercise(id, userID, date, shakes, isValid));
                    }
                    lExercises.AddRange(exercises);
                }
                return lExercises; // Return the list of users
            }
        }
        private static List<Battle> lBattles = new List<Battle>();
        public static List<Battle> battles
        {
            get
            {
                needUpdate();
                if (updateLists[5])
                {
                    updateLists[5] = false;
                    List<Object> results = selectQuery("SELECT * FROM tbl_BATTLE"); // Do query
                    List<Battle> battles = new List<Battle>();
                    foreach (List<Object> result in results) // Loop through rows
                    {
                        // Cast the columns
                        int id = (int)result[0];
                        DateTime date = (DateTime)result[1];
                        int challengerID = (int)result[2];
                        int opponentID = (int)result[3];
                        int winnerID = (int)result[4];
                        int xp = (int)result[5];
                        battles.Add(new Battle(id, date, challengerID, opponentID, winnerID, xp));
                    }
                    lBattles.AddRange(battles);
                }
                return lBattles; // Return the list of users
            }
        }
        private static List<HallOfFame> lHallOfFames = new List<HallOfFame>();
        public static List<HallOfFame> hallOfFames
        {
            get
            {
                needUpdate();
                if (updateLists[6])
                {
                    updateLists[6] = false;
                    List<Object> results = selectQuery("SELECT * FROM tbl_HALL_OF_FAME"); // Do query
                    List<HallOfFame> hallOfFames = new List<HallOfFame>();
                    foreach (List<Object> result in results) // Loop through rows
                    {
                        // Cast the columns
                        int id = (int)result[0];
                        DateTime date = (DateTime)result[1];
                        int userCharacterID = (int)result[2];

                        hallOfFames.Add(new HallOfFame(id, userCharacterID, date));
                    }
                    lHallOfFames.AddRange(hallOfFames);
                }
                return lHallOfFames; // Return the list of users
            }
        }

        public static List<Object> selectQuery(String query) 
        {
            // Connection
            //String server = "ZORO", String database = "db_BETTER", String userId = "student", String password = "password"
            //string connectionString = "server=" + server + ";database=" + database + ";user id=" + userId + ";pwd=" + password;
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ToString());

            //Create SQL command to be sent
            SqlCommand cmd = new SqlCommand(query, connection);

            //Open the SQL connection
            connection.Open();

            //Execute command
            SqlDataReader result = cmd.ExecuteReader();

            List<Object> results = new List<Object>();
            while (result.Read()) // Loop through rows
            {
                List<Object> row = new List<Object>();
                for (int i = 0; i < result.FieldCount; i++ )
                    row.Add(result[i]);
                results.Add(row);
            }

            //Close the connection
            connection.Close();

            return results;
        }

        public static void addQuery(String query)
        {
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ToString());
            
            connection.Open();
            
            //Create Command object

            SqlCommand addCmd = new SqlCommand(query, connection);
            addCmd.ExecuteNonQuery();
            connection.Close();

        }

        public static string getQuery(String query)
        {
            String queryResult = "";
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["connectionString"].ToString());

            connection.Open();

            SqlCommand getCmd = new SqlCommand(query, connection);
            SqlDataReader result = getCmd.ExecuteReader();

            
            while (result.Read()) // Loop through rows
            {
                queryResult = (String)result[0].ToString(); 
            }

          
               
            

            
            
            return queryResult;
        }


    }
}
