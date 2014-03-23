using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BetterWebApp.Models
{
    public class Battle
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

        private int sChallengerID;
        public int challengerID
        {
            get
            {
                return sChallengerID;
            }
            set
            {
                sChallengerID = value;
                Utilities.addQuery("UPDATE tbl_BATTLE SET intChallenger='" + sChallengerID + "' WHERE intId='" + id + "';");
            }
        }
        private int sOpponentID;
        public int opponentID
        {
            get
            {
                return sOpponentID;
            }
            set
            {
                sOpponentID = value;
                Utilities.addQuery("UPDATE tbl_BATTLE SET intOpponent='" + sOpponentID + "' WHERE intId='" + id + "';");

            }
        }
        private int sWinnerID;
        public int winnerID
        {
            get
            {
                return sWinnerID;
            }
            set
            {
                sWinnerID = value;
                Utilities.addQuery("UPDATE tbl_BATTLE SET intWinner='" + sWinnerID + "' WHERE intId='"+id+"';");
            }
        }
        private int sXp;
        public int xp
        {
            get
            {
                return sXp;
            }
            set
            {
                sXp = value;
                Utilities.addQuery("UPDATE tbl_BATTLE SET intXp='" + sXp + "' WHERE intId='" + id + "';");
            }
        }

        public Battle(int id, DateTime date, int challengerID, int opponentID, int winnerID, int xp)
        {
            // Information provided was not from database, better add it to the database
            int countVal = Convert.ToInt32(Utilities.getQuery("SELECT COUNT(*) FROM tbl_BATTLE;"));
            if (countVal == 0)
            {
                if (id > countVal)
                    Utilities.addQuery("INSERT INTO tbl_BATTLE (intOpponent, intChallenger, intWinner, intXp) VALUES(" + opponent.id + "," + challenger.id + "," + winnerID + "," + xp + ");");

                this.id = id;
                this.date = date;
                this.challengerID = challengerID;
                this.opponentID = opponentID;
                this.winnerID = winnerID;
                this.xp = xp;
            }
            else
            {
                this.id = id;
                this.date = date;
                this.challengerID = challengerID;
                this.opponentID = opponentID;
                this.winnerID = winnerID;
                this.xp = xp;

                if (id > countVal)
                    Utilities.addQuery("INSERT INTO tbl_BATTLE (intOpponent, intChallenger, intWinner, intXp) VALUES(" + opponent.id + "," + challenger.id + "," + winnerID + "," + xp + ");");
            }
        }

        public UserCharacter challenger
        {
            get { return Utilities.userCharacters[challengerID - 1]; } // Get the UserCharacer object of the challenger
        }
        public UserCharacter opponent
        {
            get { return Utilities.userCharacters[opponentID - 1]; } // Get the UserCharacer object of the opponent
        }
        public UserCharacter winner
        {
            get { return Utilities.userCharacters[winnerID - 1]; } // Get the UserCharacer object of the winner
        }
    }
}
