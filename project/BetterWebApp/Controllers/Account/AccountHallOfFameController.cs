using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BetterWebApp.Controllers
{
    public class AccountHallOfFameController : Controller
    {
        //
        // GET: /AccountHallOfFame/

        public ActionResult Index(int accountId)
        {
            ViewBag.hofCharacters = BetterSession.Current.user.usersHofCharacters;
            return View();
        }

    }
}
