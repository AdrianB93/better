using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BetterWebApp.Controllers
{
    public class LogoutController : Controller
    {
        //
        // GET: /logout

        public ActionResult Index()
        {
            BetterSession.Current.user = null;

            TempData["loggedout"] = true;
            return Redirect("/");
        }

    }
}
