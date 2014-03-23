using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BetterWebApp.Models
{
    public class UserCharacter
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
        private String sName;
        public String name
        {
            get
            {
                return sName;
            }
            set
            {
                sName = value;
                Utilities.addQuery("UPDATE tbl_USER_CHARACTER SET strName='" + sName + "' WHERE intId='" + id + "';");
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
                Utilities.addQuery("UPDATE tbl_USER_CHARACTER SET intXp='" + sXp + "' WHERE intId='" + id + "';");
                if (this.xp > 11500)
                {
                    isActivated = false;
                    Utilities.hallOfFames.Add(new HallOfFame(Utilities.hallOfFames.Count + 1, this.id, DateTime.Now));
                }
            }
        }
        private DateTime sBirth;
        public DateTime birth
        {
            get
            {
                return sBirth;
            }
            set
            {
                sBirth = value;
                
            }
        }
        private string sImageFileName;
        public string imageFileName // Get the folder group and image name, return in single string
        {
            get
            {
                if (this.sImageFileName == "") // Not overidden, get the default value
                    return (this.fixedCharacter.element.name.ToLower() + "/" + this.fixedCharacter.imageFileName);
                else return ("custom/" + sImageFileName);
            }
            set 
            { 
                sImageFileName = value;
                
            }

        }


        private bool sIsActivated;
        public bool isActivated
        {
            get
            {
                return sIsActivated;
            }
            set
            {
                sIsActivated = value;
                Utilities.addQuery("UPDATE tbl_USER_CHARACTER SET isActivated='" + sIsActivated + "' WHERE intId='" + id + "';");
            }
        }
        private bool sIsVisible;
        public bool isVisible
        {
            get
            {
                return sIsVisible;
            }
            set
            {
                sIsVisible = value;
                Utilities.addQuery("UPDATE tbl_USER_CHARACTER SET isVisible='" + sIsVisible + "' WHERE intId='" + id + "';");
            }
        }
        private int sFixedCharacterId;
        public int fixedCharacterId
        {
            get
            {
                return sFixedCharacterId;
            }
            set
            {
                sFixedCharacterId = value;
                Utilities.addQuery("UPDATE tbl_USER_CHARACTER SET intFixedCharacter='" + sFixedCharacterId + "' WHERE intId='" + id + "';");
            }
        }
        private int sOwnerId;
        public int ownerId
        {
            get
            {
                return sOwnerId;
            }
            set
            {
                sOwnerId = value;
                Utilities.addQuery("UPDATE tbl_USER_CHARACTER SET intUserOwner='" + sOwnerId + "' WHERE intId='" + id + "';");
            }
        }

        public UserCharacter(int id, String name, int xp, DateTime birth, String imageFileName, bool isActivated, bool isVisible, int fixedCharacterId, int ownerId)
        {
            // Information provided was not from database, better add it to the database
            int countVal = Convert.ToInt32(Utilities.getQuery("SELECT COUNT(*) FROM tbl_USER_CHARACTER;"));
            if (countVal == 0)
            {
                if (id > countVal)
                    Utilities.addQuery("INSERT INTO tbl_USER_CHARACTER (strName, strImageFileName, intFixedCharacter, intUserOwner) VALUES('" + name + "','" + imageFileName + "','" + fixedCharacterId + "','" + ownerId + "'" + ")");

                this.id = id;
                this.name = name;
                this.xp = xp;
                this.birth = birth;
                this.imageFileName = imageFileName;
                
                this.isActivated = isActivated;
                this.isVisible = isVisible;
                this.fixedCharacterId = fixedCharacterId;
                this.ownerId = ownerId;
            }
            else
            {
                this.id = id;
                this.name = name;
                this.xp = xp;
                this.birth = birth;
                this.imageFileName = imageFileName;
                
                this.isActivated = isActivated;
                this.isVisible = isVisible;
                this.fixedCharacterId = fixedCharacterId;
                this.ownerId = ownerId;

                if (id > countVal)
                    Utilities.addQuery("INSERT INTO tbl_USER_CHARACTER (strName, strImageFileName, intFixedCharacter, intUserOwner) VALUES('" + name + "','" + imageFileName + "','" + fixedCharacterId + "','" + ownerId + "'" + ")");
            }

        }

        public User owner // Get the User object of who owns this character
        {
            get { return Utilities.users[ownerId - 1]; }
        }
        public FixedCharacter fixedCharacter // Get the fixed character object this user character is based on
        {
            get { return Utilities.fixedCharacters[this.fixedCharacterId - 1]; }
        }
        public int level // Calculate the users level
        {
            get 
            {
                if (this.xp >= 0 && this.xp <= 1000) return 1;
                else if (this.xp >= 1001 && this.xp <= 3000) return 2;
                else if (this.xp >= 3001 && this.xp <= 6400) return 3;
                else
                {
                    return 4;
                }// Because you are probably 4
                //if (xp >= 6401 || this.xp <= 11500) return 4;
            }
        }
        public int step // Calculate the users step in the level
        {
            get
            {
                if (this.level == 1)
                {
                    if (this.xp >= 0 && this.xp <= 200) return 1;
                    else if (this.xp >= 201 && this.xp <= 425) return 2;
                    else if (this.xp >= 426 && this.xp <= 675) return 3;
                    else {return 4; // Because you are probably 4
                    }
                }
                else if (this.level == 2)
                {
                    if (this.xp >= 1001 && this.xp <= 1400) return 1;
                    else if (this.xp >= 1401 && this.xp <= 1900) return 2;
                    else if (this.xp >= 1901 && this.xp <= 2400) return 3;
                    else {return 4; // Because you are probably 4
                    }
                }
                else if (this.level == 3)
                {
                    if (this.xp >= 3001 && this.xp <= 3700) return 1;
                    else if (this.xp >= 3701 && this.xp <= 4500) return 2;
                    else if (this.xp >= 4501 && this.xp <= 5400) return 3;
                    else {return 4; // Because you are probably 4
                    }
                }
                else if (this.level == 4)
                {
                    if (this.xp >= 6401 && this.xp <= 7500) return 1;
                    else if (this.xp >= 7501 && this.xp <= 8700) return 2;
                    else if (this.xp >= 8701 && this.xp <= 10000) return 3;
                    else
                    {
                        return 4; // Because you are probably 4
                    }

                }
                else { return 4; }
            }
        }
        public List<Battle> battles // Get every battle this character has participated in
        {
            get
            {
                List<Battle> battles = new List<Battle>();
                foreach (Battle b in Utilities.battles)
                    if (b.challengerID == ownerId || b.opponentID == ownerId)
                        battles.Add(b);
                return battles;
            }
        }
        public List<Battle> wins // Get every battle this character has won
        {
            get
            {
                List<Battle> wins = new List<Battle>();
                foreach (Battle b in Utilities.battles)
                    if (b.winner.id == this.id)
                        wins.Add(b);
                return wins;
            }
        }
        public List<Battle> losses // Get every battle this character has lost
        {
            get
            {
                List<Battle> losses = new List<Battle>();
                foreach (Battle b in Utilities.battles)
                    if (b.winner.id != this.id && (b.challenger.id == this.id || b.opponent.id == this.id))
                        losses.Add(b);
                return losses;
            }
        }
        public bool isHof // Get every battle this character has lost
        {
            get
            {
                bool isIt = false;
                foreach (HallOfFame hof in Utilities.hallOfFames)
                    if (hof.hofCharacter == this)
                        isIt = true;
                return isIt;
            }
        }
    }
}
