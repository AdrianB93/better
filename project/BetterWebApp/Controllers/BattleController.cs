using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BetterWebApp.Controllers
{
    public class BattleController : Controller
    {
        //
        // GET: /Battle/

        public ActionResult Index()
        {
            if (BetterSession.Current.loggedIn)
            {
                ViewBag.yourBattles = new List<Models.Battle>();
                foreach (Models.Battle b in Models.Utilities.battles)
                    if (b.challenger.owner.id == BetterSession.Current.user.id || b.opponent.owner.id == BetterSession.Current.user.id) // I was in this battle
                        ViewBag.yourBattles.Add(b);
                return View();
            }
            else return Redirect("/login");
        }

        //
        // GET: /Battle/{id}

        public ActionResult Show(int id)
        {
            if (BetterSession.Current.loggedIn)
            {
                ViewBag.battle = Models.Utilities.battles[id - 1];

                foreach (Models.UserCharacter uc in Models.Utilities.users[BetterSession.Current.user.id - 1].usersCharacters)
                    if (ViewBag.battle.challengerID == uc.id || ViewBag.battle.opponentID == uc.id)
                        ViewBag.yourId = uc.id;

                if (ViewBag.battle.winnerID == ViewBag.yourId)
                {
                    ViewBag.yourXp = ViewBag.battle.xp;
                    ViewBag.win = "YOU WON";
                }
                else
                {
                    ViewBag.yourXp = 0;
                    ViewBag.win = "YOU LOST";

                    if (ViewBag.battle.winnerID == -1)
                    {
                        ViewBag.yourXp = -1;
                        ViewBag.win = "YOU TIED";
                    }
                }

                return View();
            }
            else return Redirect("/login");
        }

    }
}
