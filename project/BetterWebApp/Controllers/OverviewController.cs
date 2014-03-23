using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BetterWebApp.Controllers
{
    public class OverviewController : Controller
    {
        // GET: /overview
        public ActionResult Index()
        {
            if (!BetterSession.Current.loggedIn) return Redirect("/");
            else
            {
                // Return all the users info for the overview to use as needed
                ViewBag.user = BetterSession.Current.user;
                ViewBag.characters = BetterSession.Current.user.usersCharacters;
                ViewBag.battles = BetterSession.Current.user.usersBattles;
                ViewBag.exercises = BetterSession.Current.user.usersExercises;
                return View();
            }
        }

    }
}
