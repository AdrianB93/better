using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BetterWebApp.Controllers
{
    public class AccountCharacterController : Controller
    {
        // NEVER USED THIS, THERE IS NOTHING TO DO WITH CHARACTERS OTHER THAN DELETING THEM AND WE HAVE THAT IN THE REGULAR CHARACTER VIEWS.
        // GET: /AccountCharacter/

        public ActionResult Index()
        {
            return View();
        }

    }
}
