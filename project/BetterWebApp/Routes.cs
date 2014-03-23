using System.Web.Routing;
using RestfulRouting;
using BetterWebApp.Controllers;
using System.Web.Mvc;

[assembly: WebActivator.PreApplicationStartMethod(typeof(BetterWebApp.Routes), "Start")]

namespace BetterWebApp
{
    public class Routes : RouteSet
    {
        public override void Map(IMapper map)
        {
            map.DebugRoute("routedebug");

            // No need for home route or reference to the SiteController as ASP.NET's default routing takes care of it.

            map.Resources<RegisterController>(account =>
            {
                account.As("register"); // De-pluraliser
                account.Only("index", "create"); // Register
            });
            map.Resources<LoginController>(login =>
            {
                login.As("login"); // De-pluraliser
                login.Only("index", "create"); // Create is for creating session
            });
            map.Resources<LogoutController>(logout =>
            {
                logout.As("login"); // De-pluraliser
                logout.Only("index"); // Create is for creating session
            });

            map.Resources<AccountController>(account =>
            {
                // This is using the same default AccountController, the /players will look up other players, their characters, and their characters hall of fame.
                account.As("players"); 
                account.Only("index", "show"); // Only show, the default account set up handles index, PUT, and DELETE
                account.Resources<AccountHallOfFameController>(playerHOF =>
                {
                    playerHOF.Only("index"); // There is already a way to view individual hall of fame characters (halloffame/{id})
                    playerHOF.As("halloffame");
                });
                account.Resources<AccountCharacterController>(playerCharacters =>
                {
                    playerCharacters.Only("index"); // There is already a way to view individual characters (characters/{id})
                    playerCharacters.As("characters");
                });
            });

            map.Resources<CharacterController>(character =>
            {
                character.Resources<CombatController>(combat => 
                { 
                    combat.Only("create", "new");
                    combat.As("combat"); // De-pluraliser
                });
                character.Resources<ExerciseAllocateController>(exalloc => 
                { 
                    exalloc.Only("create", "new");
                    exalloc.As("exerciseallocate"); // De-pluraliser
                });
            });

            map.Resources<HallOfFameController>(hof => 
            {
                hof.Only("index", "show");
                hof.As("halloffame"); // De-pluraliser
            });
            map.Resources<BattleController>(battle => battle.Only("index", "show"));
            map.Resources<ExerciseController>(exercise => 
            { 
                exercise.Only("index", "create", "new", "edit"); // No need for show, index will have all the info needed. Edit needed to validate exercise
                exercise.As("exercise"); // De-pluraliser
            });

            /*
             * TODO: Figure out what areas are.
             * 

            map.Area<Controllers.Admin.BlogsController>("admin", admin =>
            {
                admin.Resources<Controllers.Admin.BlogsController>();
                admin.Resources<Controllers.Admin.PostsController>();
            });
             */
        }

        public static void Start()
        {
            var routes = RouteTable.Routes;
            routes.MapRoutes<Routes>();
        }
    }
}