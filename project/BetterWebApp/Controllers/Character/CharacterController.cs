using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;

namespace BetterWebApp.Controllers
{
    public class CharacterController : Controller
    {
        //
        // GET: /Character

        public ActionResult Index()
        {
            ViewBag.success = false;
            ViewBag.error = false;

            // Show all characters
            ViewBag.characters = new List<Models.UserCharacter>();
            foreach (Models.UserCharacter uc in Models.Utilities.userCharacters) 
                if (uc.isActivated && !uc.isHof)
                    ViewBag.characters.Add(uc);
            return View();
        }

        //
        // GET: /Character/{id}

        public ActionResult Show(int id)
        {
            ViewBag.id = id;
            ViewBag.character = Models.Utilities.userCharacters[id - 1]; // Return the UserCharacter object (easier)
            return View(); // Show one character
        }

        //
        // POST: /Character

        public ActionResult Create()
        {
            if (BetterSession.Current.loggedIn)
            {
                string name = Request["monsterName"];
                int element = Convert.ToInt32(Request["element"]);
                HttpPostedFileBase file = Request.Files["fileupload"];
                string imageFileName = "";
                if (file != null && file.ContentLength > 0)
                {
                    //string fname = Path.GetFileName(file.FileName);
                    file.SaveAs(Server.MapPath(Path.Combine("~/images/characters/custom/", (Models.Utilities.userCharacters.Count + 1).ToString().PadLeft(8, '0') + ".png")));
                    imageFileName = (Models.Utilities.userCharacters.Count + 1).ToString().PadLeft(8, '0')+".png";
                }
                
                
                foreach (Models.UserCharacter uc in BetterSession.Current.user.usersCharacters)
                    if (uc.fixedCharacter.element.id == element)
                    {
                        ViewBag.error = true;
                        ViewBag.errorMsg = "You already have a " + uc.fixedCharacter.element.name + " character.";
                        ViewBag.monsterName = name;
                        return View("New");
                    }


                //Models.Utilities.addQuery("INSERT INTO tbl_USER_CHARACTER (strName, intFixedCharacter, intUserOwner) VALUES('" + name + "','" + element + "','" + BetterSession.Current.user.id + "'" + ")");
                Models.Utilities.userCharacters.Add(new Models.UserCharacter((Models.Utilities.userCharacters.Count + 1), name, 0, DateTime.Now, imageFileName, true, true, element, BetterSession.Current.user.id));

                return Redirect("/characters/" + Models.Utilities.userCharacters.Count);
            }
            else return Redirect("/login");
        }

        //
        // GET: /Character/New

        public ActionResult New()
        {
            if (BetterSession.Current.loggedIn)
            {
                // Create new character form
                ViewBag.monsterName = "";
                ViewBag.error = false;
                return View();
            }
            else return Redirect("/login");
        }

        //
        // GET: /Character/{id}/edit

        public ActionResult Edit()
        {
            if (BetterSession.Current.loggedIn)
            {
                // Edit character form
                ViewBag.error = false;
                return View();
            }
            else return Redirect("/login");
        }

        //
        // PUT: /Character/{id}

        public ActionResult Update(int id)
        {
            // With each form element posted, change the values of the targeted UserCharacter object.
            return Show(1);
        }

        //
        // DELETE: /Character/{id}

        public ActionResult Destroy(int id)
        {
            // Deactivate character, don't delete
            Models.Utilities.userCharacters[id - 1].isActivated = false;
            ViewBag.error = false;
            ViewBag.success = true;
            ViewBag.successMsg = "Character has been succesfully deleted.";
            return Redirect("/characters");
        }

    }
}
