using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BetterWebApp.Controllers
{
    public class HallOfFameController : Controller
    {
        //
        // GET: /HallOfFame/

        public ActionResult Index()
        {
            ViewBag.hallOfFameUsers = new List<Models.UserCharacter>();
            foreach (Models.HallOfFame hof in Models.Utilities.hallOfFames)
                ViewBag.hallOfFameUsers.Add(hof.hofCharacter);
            return View();
        }

        //
        // GET: /HallOfFame/All
        // GET: /HallOfFame/{id}

        public ActionResult Show(int id)
        {
            ViewBag.id = id;
            ViewBag.character = Models.Utilities.userCharacters[id - 1]; // Return the UserCharacter object (easier)
            // Show one hof character
            return View();
        }

    }
}
