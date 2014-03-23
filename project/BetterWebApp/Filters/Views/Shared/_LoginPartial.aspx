<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<% if (BetterWebApp.BetterSession.Current.loggedIn)
   { %>
    Hello, <%: BetterWebApp.BetterSession.Current.user.username %>! <a href="/players/<%: BetterWebApp.BetterSession.Current.user.id %>">Account</a> / <a href="/logout">Log off</a>
<% } 
   else { %>
    <%: Html.ActionLink("Log in", "Index", "Login", routeValues: null, htmlAttributes: new { id = "loginLink" })%> / 
    <%: Html.ActionLink("Register", "Index", "Register", routeValues: null, htmlAttributes: new { id = "registerLink" })%>
<% } %>