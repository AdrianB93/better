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
    public class AccountController : Controller
    {
        //Show all characters

        public ActionResult Index()
        {
            if (BetterSession.Current.loggedIn)
            {
                List<object> usernames = new List<object>();
                foreach (Models.User myuser in Models.Utilities.users) usernames.Add(myuser);
                
                ViewBag.users = usernames.ToArray();
                usernames.Clear();

                return View();
            }
            else return Redirect("/login");
        }

        // GET: /players

        

        //
        // GET: /players/{id}

        public ActionResult Show(int id)
        {
            if (BetterSession.Current.loggedIn)
            {
                ViewBag.users = Models.Utilities.users[id - 1]; // Return the UserCharacter object (easier)
                ViewBag.usersCharacters = Models.Utilities.users[id - 1].usersCharacters;
                return View();
            }
            else return Redirect("/login");
        }

        //
        // POST: /account

        public ActionResult Create()
        {
            ViewBag.user = Models.Utilities.users[BetterSession.Current.user.id - 1];
            string email = Request["email"];
            string parentemail = Request["parentemail"];
            string password = EncodePassword(Request["password"]); // HASH ME!!!
            string confirmpassword = EncodePassword(Request["confirmpassword"]);

            Regex regex = new Regex(@"^[\w!#$%&'*+\-/=?\^_`{|}~]+(\.[\w!#$%&'*+\-/=?\^_`{|}~]+)*" + "@" + @"((([\-\w]+\.)+[a-zA-Z]{2,4})|(([0-9]{1,3}\.){3}[0-9]{1,3}))$");
            Match emailMatch = regex.Match(email);
            if (emailMatch.Success == false && email != "")
            {
                ViewBag.error = true;
                ViewBag.errorMsg = "The email you entered is invalid";
                return View("New");
            }
            Match parentEmailMatch = regex.Match(parentemail);
            if (parentEmailMatch.Success == false && parentemail != "")
            {
                ViewBag.error = true;
                ViewBag.errorMsg = "Your parent's email is invalid";
                return View("New");
            }
            foreach (Models.User u in Models.Utilities.users)
            {
                if (u.email == Request["email"])
                {
                    ViewBag.error = true;
                    ViewBag.errorMsg = "An account with that email address already exists";
                    return View("New");
                }
                
                else
                {
                    ViewBag.error = false;
                }  
            }         
            ViewBag.error = false;

            if (password == confirmpassword)
            {
                //Models.Utilities.users.Add(new Models.User((Models.Utilities.users.Count + 1), username, email, parentemail, password, DateTime.Now, true, true, true, 0, 0));
                if (email != "")
                {
                    Models.Utilities.users[BetterSession.Current.user.id - 1].email = email;
                }
                if (parentemail != "")
                {
                    Models.Utilities.users[BetterSession.Current.user.id - 1].parentEmail = parentemail;
                }
                if (password != "")
                {
                    Models.Utilities.users[BetterSession.Current.user.id - 1].hashedPassword = password;
                }


                return Redirect("/Overview");
            }
            else
            {
                ViewBag.error = true;
                ViewBag.errorMsg = "Your passwords do not match";
                return View("New");
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

           

        //
        // GET: /account/New

        public ActionResult New()
        {
            if (BetterSession.Current.loggedIn)
            {
                ViewBag.error = false;

                ViewBag.usersCharacters = BetterSession.Current.user.usersCharacters;
                ViewBag.users = Models.Utilities.users[BetterSession.Current.user.id - 1];
                return View();

            }





            else return Redirect("/login");
            
        }

    }
}
