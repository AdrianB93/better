using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BetterWebApp.Models
{
    public class HallOfFame
    {
        private int sId;
        public int id
        {
            get
            {
                return sId;
            }

            set
            {
                sId = value;
            }
        }
        
       
        private int sUserCharacterID;
        public int userCharacterID
        {
            get
            {
                return sUserCharacterID;
            }
            set
            {
                sUserCharacterID = value;
                Utilities.addQuery("UPDATE tbl_HALL_OF_FAME SET intUserCharacter='" + sUserCharacterID+ "' WHERE intId='" + id + "';");
            }
        }
        private DateTime sDate;
        public DateTime date
        {
            get
            {
                return sDate;
            }
            set
            {
                sDate = value;
            }
        }

        public HallOfFame(int id, int userCharacterID, DateTime date)
        {

            // Information provided was not from database, better add it to the database
            int countVal = Convert.ToInt32(Utilities.getQuery("SELECT COUNT(*) FROM tbl_HALL_OF_FAME;"));
            if (countVal == 0)
            {
                if (id > countVal)
                    Utilities.addQuery("INSERT INTO tbl_HALL_OF_FAME (intUserCharacter) VALUES(" + userCharacterID + ");");

                this.id = id;
                this.userCharacterID = userCharacterID;
                this.date = date;
            }
            else
            {
                this.id = id;
                this.userCharacterID = userCharacterID;
                this.date = date;

                if (id > countVal)
                    Utilities.addQuery("INSERT INTO tbl_HALL_OF_FAME (intUserCharacter) VALUES(" + userCharacterID + ");");
            }
            
            
            
            
            this.userCharacterID = userCharacterID;
            this.date = date;
        }

        public UserCharacter hofCharacter
        {
            get
            {
                return Utilities.userCharacters[userCharacterID - 1];
            }
        }
    }
}
