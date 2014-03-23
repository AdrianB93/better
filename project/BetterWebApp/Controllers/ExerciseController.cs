using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Xml;
using System.Xml.Linq;
using System.IO;

namespace BetterWebApp.Controllers
{
    public class ExerciseController : Controller
    {
        //
        // GET: /Exercise/

        public ActionResult Index()
        {
            if (BetterSession.Current.loggedIn)
            {
                ViewBag.exercises = Models.Utilities.users[BetterSession.Current.user.id - 1].usersExercises;
                ViewBag.error = false;
                return View();
            }
            else return Redirect("/login");
        }

        public ActionResult Show()
        {
            if (BetterSession.Current.loggedIn) return View();
            else return Redirect("/");
        }

        public ActionResult Edit()
        {
            if (BetterSession.Current.loggedIn) return View();
            else return Redirect("/");
        }

        public ActionResult Create()
        {
            //String myxmlUrl = Request["xmlupload"];
            HttpPostedFileBase file = Request.Files["xmlupload"];
            String pinCode = Request["pinCode"];
            int myShakes = 0;
            ViewBag.error = false;

            if (file != null && file.ContentLength > 0)
            {
                
                file.SaveAs(Server.MapPath(Path.Combine("~/xml/", BetterSession.Current.user.id.ToString() + ".xml" )));
                myShakes = Convert.ToInt32(ReadXml(BetterSession.Current.user.id.ToString()));
            }

            if ( pinCode == Convert.ToString(BetterWebApp.BetterSession.Current.user.parentPIN))
            {
                //Models.Utilities.addQuery("INSERT INTO tbl_EXERCISE (intUsersId, intShakes, isValid) VALUES('" + BetterSession.Current.user.id + "','" + myShakes + "','" + 1 + "'" + ")");
                Models.Utilities.exercises.Add(new Models.Exercise((Models.Utilities.exercises.Count + 1), BetterSession.Current.user.id, DateTime.Now, myShakes, true));
                Models.Utilities.users[BetterSession.Current.user.id - 1].totalXP += Convert.ToInt32(myShakes / 2);
                Models.Utilities.users[BetterSession.Current.user.id - 1].exerciseXP += Convert.ToInt32(myShakes / 2);
                return Redirect("/exercise");
            }
            else
            {
                ViewBag.error = true;
                ViewBag.errorMsg = "Your Parent Pin is incorrect";
                return View("New");
            }
        }
        
        public ActionResult New()
        {
            if (BetterSession.Current.loggedIn)
            {  
                if (ViewBag.error == null) 
                    ViewBag.error = false;
                return View();
            }
            else return Redirect("/");
        }

        public String ReadXml(String xmlURL)
        {
            XDocument doc = XDocument.Load(Server.MapPath(Path.Combine("~/xml/", BetterSession.Current.user.id.ToString() + ".xml")));
            XElement root = doc.Root;
            String noOfShakes = "0"; 
            foreach (XElement e in root.Elements("shakes")) 
                noOfShakes = e.Value;
            return noOfShakes;
        }

    }
}
