<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Home - B.E.T.T.E.R.
</asp:Content>

<asp:Content ID="indexFeatured" ContentPlaceHolderID="FeaturedContent" runat="server">
    <div class="splash">
            <div class="container">
                <img src="assets/img/splashscreen.png" alt="Welcome Splash" />
            </div>
    </div>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="bigtitle">
        <h1>Welcome to B.E.T.T.E.R!</h1>
        <p class="MainScreen">Battling Elemental Titans Through Exercise Routines is an exciting and fun new game where you can create monsters and battle them to level up!</p>
        <p class="MainScreen">Exercise with your compatible pedometer to level up your monsters even quicker and enter the HALL OF FAME!</p>
    </div>
</asp:Content>
