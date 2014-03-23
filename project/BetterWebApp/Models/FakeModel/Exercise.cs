using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BetterWebApp.Models
{
    public class Exercise
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
        private int sUserID;
        public int userID
        {
            get
            {
                return sUserID;
            }
            set
            {
                sUserID = value;
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
        private int sShakes;
        public int shakes
        {
            get
            {
                return sShakes;
            }
            set
            {
                sShakes = value;
            }
        }
        private bool sIsValid;
        public bool isValid
        {
            get
            {
                return sIsValid;
            }
            set
            {
                sIsValid = value;
            }
        }

        public Exercise(int id, int userID, DateTime date, int shakes, bool isValid)
        {

            int countVal = Convert.ToInt32(Utilities.getQuery("SELECT COUNT(*) FROM tbl_EXERCISE;"));

            if (countVal == 0)
            {
                if (id > countVal)
                {

                    Utilities.addQuery("INSERT INTO tbl_EXERCISE (intUsersId, intShakes, isValid) VALUES('" + id + "','" + shakes + "','" + 1 + "'" + ")");
                }

                this.id = id;
                this.userID = userID;
                this.date = date;
                this.shakes = shakes;
                this.isValid = isValid;
            }

            else
            {
                this.id = id;
                this.userID = userID;
                this.date = date;
                this.shakes = shakes;
                this.isValid = isValid;

                if (id > countVal)
                {

                    Utilities.addQuery("INSERT INTO tbl_EXERCISE (intUsersId, intShakes, isValid) VALUES('" + userID + "','" + shakes + "','" + 1 + "'" + ")");
                }


            }
    
        }
        public User owner // Get the User object of the owner who did this exercise
        {
            get { return Utilities.users[userID - 1]; }
        }
    }
}