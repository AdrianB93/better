using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BetterWebApp
{
    // I've made this class to make accessing sessions cleaner.
    // It's technically the only thing stored in the session, the clean thing 
    // is the static property that gets this classes instance from the session.
    public class BetterSession
    {
        // Properties
        public bool loggedIn { get; set; }
        public Models.User user { get; set; }

        // Constructor
        private BetterSession() { this.user = null; }

        // Get this classes instance from the session, otherwise create new blank session
        public static BetterSession Current
        {
            // Properties don't have parameters, so just because this class is returned, 
            // doesn't mean the user is logged in. I just needed to return something..
            get
            {
                BetterSession session = (BetterSession)HttpContext.Current.Session["BetterSession"];
                if (session == null)
                {
                    session = new BetterSession();
                    session.user = Models.Utilities.users[3]; // DELETE ME!!!!!
                    HttpContext.Current.Session["BetterSession"] = session;
                }

                // Always check if user object is valid
                if (session.user != null) session.loggedIn = true;
                else session.loggedIn = false;

                return session;
            }
        }
    }
}
