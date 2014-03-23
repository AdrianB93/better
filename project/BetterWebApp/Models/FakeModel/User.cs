using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BetterWebApp.Models
{
    public class User
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

        private String sUsername;
        public String username 
        {
            get
            {
                return sUsername;
            }
            set
            {
                sUsername = value;
                Utilities.addQuery("UPDATE tbl_USERS SET strUsername='" + sUsername + "' WHERE intId='" + id + "';");
            }
        }
        private String sEmail;
        public String email
        {
            get
            {
                return sEmail;
            }
            set
            {
                sEmail = value;
                Utilities.addQuery("UPDATE tbl_USERS SET strEmail='" + sEmail + "' WHERE intId='" + id + "';");
            }
        }
        private String sParentEmail;
        public String parentEmail
        {
            get
            {
                return sParentEmail;
            }
            set
            {
                sParentEmail = value;
                Utilities.addQuery("UPDATE tbl_USERS SET strParentEmail='" + sParentEmail + "' WHERE intId='" + id + "';");
            } 
        }



        private int sParentPIN;
        public int parentPIN
        {
            get
            {
                return sParentPIN;
            }
            set
            {
                sParentPIN = value;
            }
        }
        
        private String sHashedPassword;
        public String hashedPassword
        {
            get
            {
                return sHashedPassword;
            }
            set
            {
                sHashedPassword = value;
                Utilities.addQuery("UPDATE tbl_USERS SET strHashedPassword='" + sHashedPassword + "' WHERE intId='" + id + "';");
            }
        }

        private DateTime sRegistrationDate;
        public DateTime registrationDate
        {
            get
            {
                return sRegistrationDate;
            }
            set
            {
                sRegistrationDate = value;
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
                Utilities.addQuery("UPDATE tbl_USERS SET isActivated='" + sIsActivated + "' WHERE intId='" + id + "';");
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
                Utilities.addQuery("UPDATE tbl_USERS SET isVisible='" + sIsVisible + "' WHERE intId='" + id + "';");
            }
        }
        private bool sIsPublic;
        public bool isPublic
        {
            get
            {
                return sIsPublic;
            }
            set
            {
                sIsPublic = value;
                Utilities.addQuery("UPDATE tbl_USERS SET isPublic='" + sIsPublic + "' WHERE intId='" + id + "';");
            }
        }

        private int sTotalXP;
        public int totalXP
        {
            get
            {
                return sTotalXP;
            }

            set
            {
                sTotalXP = value;
                Utilities.addQuery("UPDATE tbl_USERS SET intTotalXP='" + sTotalXP + "' WHERE intId='" + id + "';");
            }

        }

        private int sExerciseXP;
        public int exerciseXP
        {
            get
            {
                return sExerciseXP;
            }
            set
            {
                sExerciseXP = value;
                Utilities.addQuery("UPDATE tbl_USERS SET intExerciseXP='" + sExerciseXP + "' WHERE intId='" + id + "';");
            }
        }

        public User(int id, String username, String email, String parentEmail, String hashedPassword, DateTime registrationDate, bool isActivated, bool isVisible, bool isPublic, int totalXP, int exerciseXP)
        { 
            int countVal = Convert.ToInt32(Utilities.getQuery("SELECT COUNT(*) FROM tbl_USERS;"));

            if (countVal == 0)
            {
                if (id > countVal)
                {

                    Utilities.addQuery("INSERT INTO tbl_USERS (strUsername, strEmail, strParentEmail, strHashedPassword) VALUES('" + username + "','" + email + "','" + parentEmail + "','" + hashedPassword + "')");
                }

                this.id = id;
                this.username = username;
                this.email = email;
                this.parentEmail = parentEmail;
                this.parentPIN = new Random().Next(1000, 9999); // 4 Digit pin
                this.hashedPassword = hashedPassword;
                this.registrationDate = registrationDate;
                this.isActivated = isActivated;
                this.isVisible = isVisible;
                this.isPublic = isPublic;
                this.totalXP = totalXP;
                this.exerciseXP = exerciseXP;
            }

            else
            {
                this.id = id;
                this.username = username;
                this.email = email;
                this.parentEmail = parentEmail;
                this.parentPIN = new Random().Next(1000, 9999); // 4 Digit pin
                this.hashedPassword = hashedPassword;
                this.registrationDate = registrationDate;
                this.isActivated = isActivated;
                this.isVisible = isVisible;
                this.isPublic = isPublic;
                this.totalXP = totalXP;
                this.exerciseXP = exerciseXP;

                if (id > countVal)
                {

                    Utilities.addQuery("INSERT INTO tbl_USERS (strUsername, strEmail, strParentEmail, strHashedPassword) VALUES('" + username + "','" + email + "','" + parentEmail + "','" + hashedPassword + "')");
                }


            }
            
      
        }

        public List<UserCharacter> usersCharacters // Get every character owned by this user
        {
            get
            {
                List<UserCharacter> usersCharacters = new List<UserCharacter>();
                foreach (UserCharacter uc in Models.Utilities.userCharacters)
                    if (uc.owner.id == this.id && !uc.isHof) usersCharacters.Add(uc);
                return usersCharacters;
            }
        }
        public List<UserCharacter> usersHofCharacters // Get every character in the hall of fame owned by this user
        {
            get
            {
                List<UserCharacter> usersHofCharacters = new List<UserCharacter>();
                foreach (UserCharacter uc in Models.Utilities.userCharacters)
                    if (uc.owner.id == this.id && uc.isActivated)
                    {
                        foreach (HallOfFame hof in Utilities.hallOfFames)
                            if (hof.hofCharacter == uc)
                                usersHofCharacters.Add(uc);
                    }
                return usersHofCharacters;
            }
        }
        public List<Exercise> usersExercises // Get every exercise done by this user
        {
            get
            {
                List<Exercise> usersExercise = new List<Exercise>();
                foreach (Exercise e in Models.Utilities.exercises)
                    if (e.owner.id == this.id) usersExercise.Add(e);
                return usersExercise;
            }
        }
        public List<Battle> usersBattles // Get every battle this user participated in
        {
            get
            {
                List<Battle> usersBattles = new List<Battle>();
                foreach (Battle b in Models.Utilities.battles)
                    if (b.challengerID == this.id || b.opponentID == this.id) usersBattles.Add(b);
                return usersBattles;
            }
        }
    }
}