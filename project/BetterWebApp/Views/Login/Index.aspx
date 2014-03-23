<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<BetterWebApp.Models.LoginModel>" %>

<asp:Content ID="loginTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Log in
</asp:Content>

<asp:Content ID="loginContent" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h1>LOG IN</h1>
    </hgroup>

    <section id="loginForm">
    <% using (Html.BeginForm(new { ReturnUrl = ViewBag.ReturnUrl })) { %>
        <%: Html.AntiForgeryToken() %>
        <%: Html.ValidationSummary(true) %>
        <div class="divContainer">
        <fieldset class="registerForm">
            <legend>Log in Form</legend>
            <form action="/login" method="post">

                <div  class="registerForm-li">
                <label for="email">Email:</label>
                <span class="textboxAlign">
                <input type="text" name="email" value="<%: ViewBag.email %>" placeholder="Email Address..." /><br />
                </span>
                </div>

                <div  class="registerForm-li">
                <label for="password">Password:</label>
                <span class="textboxAlign">
                <input type="password" name="password" placeholder="Password..." /><br />
                    <a href="/login/ForgotPassword" class="statTextHead">I forgot my password.</a>
                </span>
                </div>

                <div class="centerMaker">
                    <br />
                    <input type="submit" value="Log in" />
                </div>
            </form>
        </fieldset>
            </div>
        <p id="regiP" class="centerMaker">
            <a href="/register">Register</a> if you don't have an account.
        </p>
    <% } %>
    </section>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <% if (ViewBag.error) { %>
    <h1>ERROR</h1>
    <p style="text-align: center;"><%: ViewBag.errorMsg %></p>
    <% } %>
</asp:Content>

