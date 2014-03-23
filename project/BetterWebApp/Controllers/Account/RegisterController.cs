using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Text;
using System.Security.Cryptography;
using System.Text.RegularExpressions;

namespace BetterWebApp.Controllers
{
    public class RegisterController : Controller
    {
        //
        // GET: /register

        public ActionResult Index()
        {
            if (ViewBag.error == null)
            {
                ViewBag.error = false;

            }
            if (BetterSession.Current.loggedIn)
            {

               
                return Redirect("/");
            }
            else return View();
        }

        //
        // POST: /register

        public ActionResult Create()
        {
            string email = Request["email"];
            string parentemail = Request["parentemail"];
            string username = Request["username"];
            string password = EncodePassword(Request["password"]); // HASH ME!!!
            string confirmpassword = EncodePassword(Request["confirmpassword"]);

            Regex regex = new Regex(@"^[\w!#$%&'*+\-/=?\^_`{|}~]+(\.[\w!#$%&'*+\-/=?\^_`{|}~]+)*" + "@" + @"((([\-\w]+\.)+[a-zA-Z]{2,4})|(([0-9]{1,3}\.){3}[0-9]{1,3}))$");
            Match emailMatch = regex.Match(email);
            if (emailMatch.Success == false)
            {
                ViewBag.error = true;
                ViewBag.errorMsg = "The email you entered is invalid";
                return View("Index");
            }
            Match parentEmailMatch = regex.Match(parentemail);
            if (parentEmailMatch.Success == false)
            {
                ViewBag.error = true;
                ViewBag.errorMsg = "Your parent's email is invalid";
                return View("Index");
            }
            foreach (Models.User u in Models.Utilities.users)
            {
                if (u.email == Request["email"])
                {
                    ViewBag.error = true;
                    ViewBag.errorMsg = "An account with that email address already exists";
                    return View("Index");
                }
                else if (u.username == Request["username"])
                {
                    ViewBag.error = true;
                    ViewBag.errorMsg = "That username is taken";
                    return View("Index");
                }
                else
                {
                    ViewBag.error = false;
                }  
            }         
            ViewBag.error = false;

            if (password == confirmpassword)
            {
                Models.Utilities.users.Add(new Models.User((Models.Utilities.users.Count + 1), username, email, parentemail, password, DateTime.Now, true, true, true, 0, 0));
                BetterSession.Current.user = Models.Utilities.users[Models.Utilities.users.Count - 1];

                return Redirect("/players/" + (Models.Utilities.users.Count));
            }
            else
            {
                ViewBag.error = true;
                ViewBag.errorMsg = "Your passwords do not match";
                return View("Index");
            }
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
