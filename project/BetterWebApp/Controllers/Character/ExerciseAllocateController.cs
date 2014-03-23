using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BetterWebApp.Controllers
{
    public class ExerciseAllocateController : Controller
    {
        //
        // GET: 404 Error

        public ActionResult Index()
        {

            if (!BetterSession.Current.loggedIn) return Redirect("/login");
            else return View();
        }

        //
        // POST: /Character/{id}/ExerciseAllocate

        public ActionResult Create()
        {



            // Allocate Exercise XP form
            // If this character belongs to you, how many of your exercise xp repository would you like to give?
            // POST a create
            if (!BetterSession.Current.loggedIn) return Redirect("/login");
            else
            {
                ViewBag.usersCharacters = BetterSession.Current.user.usersCharacters;
                ViewBag.user = Models.Utilities.users[BetterSession.Current.user.id - 1];



                int allocate1 = 0;
                int allocate2 = 0;
                int allocate3 = 0;
                int allocate4 = 0;
                int monster1 = 0;
                int monster2 = 0;
                int monster3 = 0;
                int monster4 = 0;


                if (Request["checkbx1"] != "" && Request["checkbx1"] != null)
                {
                    monster1 = Convert.ToInt32(Request["checkbx1"]);
                }
                if (Request["checkbx2"] != "" && Request["checkbx2"] != null)
                {
                    monster2 = Convert.ToInt32(Request["checkbx2"]);
                }
                if (Request["checkbx3"] != "" && Request["checkbx3"] != null)
                {
                    monster3 = Convert.ToInt32(Request["checkbx3"]);
                }
                if (Request["checkbx4"] != "" && Request["checkbx4"] != null)
                {
                    monster4 = Convert.ToInt32(Request["checkbx4"]);
                }


                if (Request["xpAllocate1"] != "" && Request["xpAllocate1"] != null)
                {
                    allocate1 = Convert.ToInt32(Request["xpAllocate1"]);
                }
                if (Request["xpAllocate2"] != "" && Request["xpAllocate2"] != null)
                {
                    allocate2 = Convert.ToInt32(Request["xpAllocate2"]);
                }
                if (Request["xpAllocate3"] != "" && Request["xpAllocate3"] != null)
                {
                    allocate3 = Convert.ToInt32(Request["xpAllocate3"]);
                }
                if (Request["xpAllocate4"] != "" && Request["xpAllocate4"] != null)
                {
                    allocate4 = Convert.ToInt32(Request["xpAllocate4"]);
                }


                int allXp = allocate1 + allocate2 + allocate3 + allocate4;


                if (allXp >= 0 && allXp <= Models.Utilities.users[BetterSession.Current.user.id - 1].exerciseXP)
                {
                if (allXp < Models.Utilities.users[BetterSession.Current.user.id - 1].exerciseXP)
                {
                    Models.Utilities.users[BetterSession.Current.user.id - 1].exerciseXP -= allXp;

                }
                else
                {
                    Models.Utilities.users[BetterSession.Current.user.id - 1].exerciseXP = 0;
                }

                
                if (monster1 != 0)
                {
                    Models.Utilities.userCharacters[monster1 - 1].xp += allocate1;
                }
                if (monster2 != 0)
                {
                    Models.Utilities.userCharacters[monster2 - 1].xp += allocate2;
                }
                if (monster3 != 0)
                {
                    Models.Utilities.userCharacters[monster3 - 1].xp += allocate3;
                }
                if (monster4 != 0)
                {
                    Models.Utilities.userCharacters[monster4 - 1].xp += allocate4;
                }

                Models.Utilities.users[BetterSession.Current.user.id - 1].totalXP += allXp;
                return Redirect("/ExerciseAllocate/New");
                }
                else
                {
                    ViewBag.error = true;
                    ViewBag.errorMsg = "You can not allocate more XP than your 'XP to Allocate'.";
                    return View("New");
                }

                
            }
        }

        //
        // GET: /Character/{id}/ExerciseAllocate/New

        public ActionResult New()
        {
            
                ViewBag.error = false;
            
            ViewBag.usersCharacters = BetterSession.Current.user.usersCharacters;
            ViewBag.user = Models.Utilities.users[BetterSession.Current.user.id - 1];
            return View();
        }
    }
}
