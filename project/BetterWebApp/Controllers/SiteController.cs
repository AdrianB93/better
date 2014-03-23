using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BetterWebApp.Controllers
{
    public class SiteController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.success = false;
            if (TempData["loggedout"] != null)
            {
                ViewBag.success = true;
                ViewBag.successMsg = "You have succesfully been logged out.";
            }
            if (BetterSession.Current.loggedIn) return Redirect("/overview");
            else return View();
        }

        public ActionResult About()
        {
            return View();
        }

        public ActionResult Help()
        {
            return View();
        }

        public ActionResult Contact()
        {
            return View();
        }
    }
}
