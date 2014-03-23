<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Forgotten Password
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="divContainer">
<h1>Forgotten Password:</h1>

        <p>Enter your email address and we will send you a temporary password!</p>

        <form>
            <label for="emailAddress">Email Address:</label>
            <span class="textboxAlign2">
                <input type="text" name="emailAddress" placeholder="Email address" />
            </span>
            <div class="centerMaker">
                    <br />
                    
                    <input type="submit" value="Send Email" />
                </div>
        </form>

</div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
