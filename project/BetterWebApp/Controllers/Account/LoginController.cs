using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Text;
using System.Security.Cryptography;

namespace BetterWebApp.Controllers
{
    public class LoginController : Controller
    {
        //
        // GET: /login

        public ActionResult Index()
        {
            ViewBag.error = false;
            ViewBag.email = "";

            if (BetterSession.Current.loggedIn) return Redirect("/");
            else return View();
        }

        //
        // POST: /login

        public ActionResult Create()
        {
            // Create stuff then: 
            foreach (Models.User u in Models.Utilities.users)
            {
                string encodedPassword = EncodePassword(Request["password"]);
                if (u.email == Request["email"] && u.hashedPassword == encodedPassword)
                {
                    BetterSession.Current.user = u;
                    BetterSession.Current.loggedIn = true;
                    return Redirect("/");
                }
            }
            ViewBag.error = true;
            ViewBag.errorMsg = "Your username or password was incorrect.";
            ViewBag.email = Request["email"];
            return View("Index");
        }

        // GET: /login/ForgotPassword

        public ActionResult ForgotPassword()
        {
            if (BetterSession.Current.loggedIn) return Redirect("/");
            else return View();
        }

        public string EncodePassword(string originalPassword)
        {
            //Declarations
            Byte[] originalBytes;
            Byte[] encodedBytes;
            MD5 md5;

            //Instantiate MD5CryptoServiceProvider, get bytes for original password and compute hash (encoded password)
            md5 = new MD5CryptoServiceProvider();
            originalBytes = ASCIIEncoding.Default.GetBytes(originalPassword);
            encodedBytes = md5.ComputeHash(originalBytes);

            //Convert encoded bytes back to a 'readable' string
            return BitConverter.ToString(encodedBytes);
        }

    }
}
