using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BetterWebApp.Controllers
{
    public class CombatController : Controller
    {

        //
        // POST: /Character/{id}/Combat
        public ActionResult Create(int characterId)
        {
            // TODO: IF STATEMENT TO SEE IF THE BATTLE CAN HAPPEN

            // Challenger / Opponent Object
            Models.UserCharacter challenger = Models.Utilities.userCharacters[Convert.ToInt32(Request["challenger"]) - 1];
            Models.UserCharacter opponent = Models.Utilities.userCharacters[characterId - 1];

            // Bonus Variables
            double challengerBonus = 0.25; // 25% for being a challenger
            double opponentBonus = 0.0;
            
            // Challenger Element Bonus
            if ((challenger.fixedCharacter.element.id == 1 && opponent.fixedCharacter.element.id == 3) || // Water vs Fire
                (challenger.fixedCharacter.element.id == 3 && opponent.fixedCharacter.element.id == 4) || // Fire  vs Air
                (challenger.fixedCharacter.element.id == 4 && opponent.fixedCharacter.element.id == 2) || // Air   vs Earth
                (challenger.fixedCharacter.element.id == 2 && opponent.fixedCharacter.element.id == 1))   // Earth vs Water
                challengerBonus += 0.15; // My element is "better" than yours

            // Opponent Element Bonus
            if ((opponent.fixedCharacter.element.id == 1 && challenger.fixedCharacter.element.id == 3) || // Water vs Fire
                (opponent.fixedCharacter.element.id == 3 && challenger.fixedCharacter.element.id == 4) || // Fire  vs Air
                (opponent.fixedCharacter.element.id == 4 && challenger.fixedCharacter.element.id == 2) || // Air   vs Earth
                (opponent.fixedCharacter.element.id == 2 && challenger.fixedCharacter.element.id == 1))   // Earth vs Water
                opponentBonus += 0.15; // Your element is "better" than mine

            // Random Experience Bonus
            if (new Random().Next(100) % 2 == 0) challengerBonus += 0.25;
            else opponentBonus += 0.25;

            // FINAL BATTLE ALGORITHM
            int winner = -1; // Default if tied
            int xp = 0; // Default if tied
            challengerBonus = challenger.xp + (int)(challenger.xp * challengerBonus); // Calculate xp strength after bonus
            opponentBonus = opponent.xp + (int)(opponent.xp * opponentBonus); // Calculate xp strength after bonus

            if (challengerBonus > opponentBonus)
            {
                winner = challenger.id;
                xp = (int)((challengerBonus + (challenger.xp * 0.25)) / 10); // Xp strength after bonus, plus winning bonus
            } 
            if (challengerBonus < opponentBonus)
            {
                winner = opponent.id;
                xp = (int)((opponentBonus + (opponent.xp * 0.25))/10); // Xp strength after bonus, plus winning bonus
            }

            // ADD BATTLE WITH INFORMATION

            Models.Utilities.battles.Add(new Models.Battle(Models.Utilities.battles.Count + 1, DateTime.Now, challenger.id, opponent.id, winner, xp));

            
            Models.Utilities.userCharacters[winner - 1].xp += xp;
            Models.Utilities.users[BetterSession.Current.user.id - 1].totalXP += xp;
            

            // SHOW THE BATTLE
            return Redirect("/Battles/" + Models.Utilities.battles[Models.Utilities.battles.Count - 1].id);
        }

        //
        // GET: /Character/{id}/Combat/New
        public ActionResult New(int characterId)
        {
            if (BetterSession.Current.loggedIn)
            {
                ViewBag.cid = characterId;
                ViewBag.usersCharacters = Models.Utilities.users[BetterSession.Current.user.id - 1].usersCharacters;
                ViewBag.opponent = Models.Utilities.userCharacters[characterId - 1];

                if (ViewBag.opponent.owner == BetterSession.Current.user) return Redirect("/characters/" + characterId);
                return View();
            }
            else return Redirect("/login");
        }

    }
}
